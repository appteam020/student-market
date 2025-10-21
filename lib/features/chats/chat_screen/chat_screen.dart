import 'package:dash_chat_3/dash_chat_3.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/chats/controller/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.chatProvider,
    required this.partnerId,
    required this.partnerName,
    required this.onesignalId,
  });
  final ChatsProvider chatProvider;
  final String partnerId;
  final String partnerName;
  final String onesignalId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${tr("chat_with")} $partnerName",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: colors.primary,
        foregroundColor: colors.textPrimary,
      ),
      body: ChangeNotifierProvider.value(
        value: chatProvider..initializeAndSubscribeToMessages(partnerId),
        child: Consumer<ChatsProvider>(
          builder: (context, value, child) {
            return DashChat3(
              messages: value.messages,

              inputOptions: InputOptions(
                sendOnEnter: true,
                alwaysShowSend: true,
                sendButtonBuilder: value.uploadFileState == RequestState.loading
                    ? (context) => CircularProgressIndicator()
                    : null,
                inputDecoration: InputDecoration(
                  hint: Text(tr('write a message')),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (value.files.isEmpty) {
                        value.pickerImages();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(tr('select_image')),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(tr('select_image_description')),
                                  ChangeNotifierProvider.value(
                                    value: value,
                                    child: Consumer<ChatsProvider>(
                                      builder: (context, value2, child) {
                                        return Wrap(
                                          children: [
                                            ...value2.files.map(
                                              (e) => Container(
                                                margin: EdgeInsets.all(10.w),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12.r),
                                                  //border: Border.all(color: colors.primary),
                                                ),
                                                width: 100,
                                                height: 100,
                                                child: Stack(
                                                  children: [
                                                    Image.file(e, fit: BoxFit.fill, width: 100, height: 100),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          value2.removeFile(e);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: colors.background,
                                                            borderRadius: BorderRadius.circular(25.r),
                                                          ),
                                                          child: Icon(Icons.close, color: colors.red, size: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(tr('cancel')),
                                ),
                                TextButton(
                                  onPressed: () {
                                    value.pickerImages();
                                    Navigator.pop(context);
                                  },
                                  child: Text(tr('select_new_images'), style: TextStyle(color: colors.primary)),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: Badge(child: Icon(Icons.image), label: Text(value.files.length.toString())),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.textSecondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.primary),
                  ),
                ),
              ),

              onSend: (val) {
                if (value.files.isNotEmpty) {
                  value.uploadFileToSupabase(val.text, partnerId, onesignalId);
                } else {
                  value.sendMessage(val.text, partnerId, value.imageUrls, onesignalId);
                }
              },
              currentUser: ChatUser(id: value.supabase.auth.currentUser!.id, firstName: value.supabase.auth.currentUser!.email!),
            );
          },
        ),
      ),
    );
  }
}
