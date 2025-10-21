import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dash_chat_3/dash_chat_3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/send_not.dart';
import 'package:market_student/features/chats/model/chat_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatsProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final currentUser = ChatUser(id: Supabase.instance.client.auth.currentUser!.id, firstName: "Me");

  //============================================================================
  // 1. منطق قائمة المحادثات (Inbox)
  //============================================================================
  RequestState _conversationsState = RequestState.init;
  RequestState get conversationsState => _conversationsState;

  List<Conversation> conversations = [];

  StreamSubscription<List<Map<String, dynamic>>>? _conversationsSubscription;

  Future<void> getConversations() async {
    if (_conversationsState == RequestState.loading) return;

    _conversationsState = RequestState.loading;
    notifyListeners();

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw 'User not authenticated!';

      final List<dynamic> rpcResponse = await supabase.rpc('get_conversation_partners', params: {'current_user_id': user.id});

      if (rpcResponse.isEmpty) {
        conversations = [];
        _conversationsState = RequestState.success;
        notifyListeners();
        return;
      }

      final List<String> partnerIds = rpcResponse.map((e) => e['partner_id'] as String).toList();

      final profilesResponse = await supabase
          .from('tb_user')
          .select('id, full_name, email, image, user_id,onesignal_id')
          .inFilter('user_id', partnerIds);

      final profilesMap = {for (var profileMap in profilesResponse) profileMap['user_id']: Profile.fromMap(profileMap)};

      final List<Conversation> tempConversations = [];
      for (var convoData in rpcResponse) {
        final partnerProfile = profilesMap[convoData['partner_id']];
        if (partnerProfile != null) {
          tempConversations.add(
            Conversation(
              partner: partnerProfile,
              lastMessage: convoData['last_message_text'] ?? 'Attachment',
              lastAttachment: convoData['last_message_attachment'],
              lastMessageSenderId: convoData['last_message_sender_id'],
              lastMessageTime: DateTime.tryParse(convoData['last_message_time'] ?? '') ?? DateTime.now(),
            ),
          );
        }
      }

      tempConversations.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

      conversations = tempConversations;
      _conversationsState = RequestState.success;
    } catch (e) {
      debugPrint('Error fetching conversations: $e');
      _conversationsState = RequestState.error;
    } finally {
      notifyListeners();
    }
  }

  void subscribeToConversations() {
    _conversationsSubscription?.cancel();
    _conversationsSubscription = supabase.from('tb_chats').stream(primaryKey: ['id']).listen((_) {
      debugPrint('🎉 New message detected! Refreshing...');
      getConversations();
    }, onError: (error) => debugPrint('Error in conversation stream: $error'));
  }

  void disposeConversationsSubscription() {
    _conversationsSubscription?.cancel();
  }

  //============================================================================
  // 2. منطق المحادثة الفردية (Chat)
  //============================================================================
  RequestState _messagesState = RequestState.init;
  RequestState get messagesState => _messagesState;

  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  StreamSubscription<List<Map<String, dynamic>>>? _messagesSubscription;

  Future<void> initializeAndSubscribeToMessages(String otherUserId) async {
    _messagesState = RequestState.loading;
    _messages = [];
    // notifyListeners();

    disposeMessagesSubscription();

    try {
      final data = await supabase.rpc(
        'get_chat_messages',
        params: {'other_user_id': otherUserId, 'current_user_id': supabase.auth.currentUser!.id},
      );

      _messages = (data as List).map((item) => _mapToChatMessage(item)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _messagesState = RequestState.success;
    } catch (e) {
      debugPrint("Error fetching messages: $e");
      _messagesState = RequestState.error;
    } finally {
      notifyListeners();
    }

    _subscribeToNewMessages(otherUserId);
  }

  void _subscribeToNewMessages(String otherUserId) {
    final currentUserId = supabase.auth.currentUser!.id;

    _messagesSubscription = supabase.from('tb_chats').stream(primaryKey: ['id']).order("created_at", ascending: false).listen((
      data,
    ) {
      if (data.isEmpty) return;

      final newMessageData = data.first;
      final senderId = newMessageData['sender_id'];
      final receiverId = newMessageData['reciver_id'];

      final isRelevant =
          (senderId == currentUserId && receiverId == otherUserId) || (senderId == otherUserId && receiverId == currentUserId);

      if (isRelevant) {
        final newChatMessage = _mapToChatMessage(newMessageData);

        if (!_messages.any((msg) => msg.customProperties?['id'] == newChatMessage.customProperties?['id'])) {
          _messages.insert(0, newChatMessage);
          notifyListeners();
        }
      }
    }, onError: (error) => debugPrint("Error in Supabase stream subscription: $error"));
  }

  Future<void> sendMessage(String text, String otherUserId, List<String> imageUrls, String onesignalId) async {
    final payload = {
      'message': text,
      'sender_id': currentUser.id,
      'reciver_id': otherUserId,
      'attachment': imageUrls.isEmpty ? null : imageUrls,
    };
    final username = await getCurrentUserName();
    String fullName = '';
    if (username != '') {
      fullName = "You have a new message From $username";
    } else {
      fullName = "You have a new message";
    }
    sendOneSignalNotification(
      playerId: onesignalId.toString(),
      title: "New Message",
      body: fullName,
      bigPicture: imageUrls.isNotEmpty ? imageUrls.first : null,
    );
    await supabase.from('tb_chats').insert(payload).then((onValue) {
      imageUrls.clear();
      notifyListeners();
    });
    await supabase.from("notifications").insert({
      "reciver_user": otherUserId,
      "message": fullName,
      "isRead": false,
      "sender_id": currentUser.id,
    });
  }

  Future<String> getCurrentUserName() async {
    final responseId = supabase.auth.currentUser?.id;
    if (responseId == null) return '';
    final response = await supabase.from('tb_user').select('full_name').eq('user_id', responseId).maybeSingle();
    return response?['full_name'] ?? '';
  }

  ChatMessage _mapToChatMessage(Map<String, dynamic> item) {
    List<ChatMedia>? medias;
    final dynamic attachmentsData = item['attachment'];

    if (attachmentsData is List) {
      medias = attachmentsData.map((element) {
        print(element);
        final url = element.toString();
        return ChatMedia(url: url, fileName: url.split('/').last, type: MediaType.image);
      }).toList();
    } else if (attachmentsData is String) {
      final List<dynamic> decodedList = jsonDecode(attachmentsData);
      medias = decodedList.map((element) {
        final url = element.toString();
        return ChatMedia(url: url, fileName: url.split('/').last, type: MediaType.image);
      }).toList();
    }

    return ChatMessage(
      user: item['sender_id'] == currentUser.id
          ? currentUser
          : ChatUser(id: item['sender_id'], firstName: item['sender_name'] ?? 'Unknown'),
      createdAt: DateTime.tryParse(item['created_at'] ?? '') ?? DateTime.now(),
      text: item['message'] ?? '',
      medias: medias, // استخدم القائمة التي تم إنشاؤها
      customProperties: {'id': item['id']},
    );
  }

  void disposeMessagesSubscription() {
    _messagesSubscription?.cancel();
  }

  List<File> _files = [];
  List<File> get files => _files;
  void addFile(File file) {
    _files.add(file);
    notifyListeners();
  }

  void removeFile(File file) {
    _files.remove(file);
    notifyListeners();
  }

  pickerImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isNotEmpty) {
      _files.addAll(pickedImages.map((e) => File(e.path)));
      notifyListeners();
    }
  }

  List<String> _imageUrls = [];
  List<String> get imageUrls => _imageUrls;
  RequestState _uploadFileState = RequestState.init;
  RequestState get uploadFileState => _uploadFileState;
  void stateUploadFileMangement(RequestState state) {
    _uploadFileState = state;
    notifyListeners();
  }

  Future<void> uploadFileToSupabase(String text, String otherUserId, String onesignalId) async {
    stateUploadFileMangement(RequestState.loading);
    try {
      Future.wait(
        files.map((file) async {
          final fileName = '${DateTime.now().millisecondsSinceEpoch}${file.path.split('/').last}';
          final response = await supabase.storage.from('chats_images').upload(fileName, file);
          final imageUrl = supabase.storage.from('chats_images').getPublicUrl(fileName);
          _imageUrls.add(imageUrl);
        }),
      ).then((onValue) {
        sendMessage(text, otherUserId, imageUrls, onesignalId);
        clearFiles();
        notifyListeners();
        stateUploadFileMangement(RequestState.success);
      });
    } catch (e) {
      stateUploadFileMangement(RequestState.error);
    }
  }

  void clearFiles() {
    _files.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    disposeConversationsSubscription();
    disposeMessagesSubscription();
    super.dispose();
  }
}
