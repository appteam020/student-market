import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';

import 'package:market_student/features/profile/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<NotificationModel> notifications = [];
  bool isReadCircle = false;
  void changeIsReadCircle(bool value) {
    isReadCircle = value;
    notifyListeners();
  }

  RequestState notificationsState = RequestState.init;
  void getNotifications() async {
    notificationsState = RequestState.loading;
    notifyListeners();
    try {
      final response = await supabase
          .from("notifications")
          .select('*, tb_user!notifications_sender_id_fkey(*)')
          .eq("reciver_user", "0c8bbaab-86da-4d96-9dcb-be31e517fe03")
          .order('created', ascending: false);
      print("SSSSSSSSSSSSS $response");
      notifications = response.map((e) => NotificationModel.fromJson(e)).toList();
      notificationsState = RequestState.success;

      notifyListeners();
    } catch (e) {
      print(e);
      notificationsState = RequestState.error;
      notifyListeners();
    }
  }
}

class NotificationModel {
  final int id;
  final String message;
  final String senderId;
  final String reciverId;
  final bool isRead;
  final DateTime created;
  final ProfileModel sender;
  NotificationModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.reciverId,
    required this.isRead,
    required this.created,
    required this.sender,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'],
      senderId: json['sender_id'],
      reciverId: json['reciver_user'],
      isRead: json['isRead'],
      created: DateTime.parse(json['created']),
      sender: ProfileModel().fromJson(json['tb_user'] as Map<String, dynamic>),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender_id': senderId,
      'reciver_id': reciverId,
      'is_read': isRead,
      'created_at': created,
    };
  }
}
