import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/notification/ui/widgets/empty_screen.dart';
import 'package:market_student/features/notification/ui/widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: tr("notifications"),
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: const Center(
          child:Column(
            children: [
            

          
       //   child: EmptyScreen(),
      NotificationCard(
        iconPath: "assets/images/icon_chat.svg", 
        title: "رسالة جديدة من أحمد", 
        description: "لقد أرسل لك أحمد رسالة جديدة.",
         timeAgo: "قبل دقيقة",),
         SizedBox(height:8),
          NotificationCard(
        iconPath: "assets/images/icon_chat.svg", 
        title: "رسالة جديدة من أحمد", 
        description: "لقد أرسل لك أحمد رسالة جديدة.",
         timeAgo: "قبل دقيقة",),
           SizedBox(height:8),
          NotificationCard(
        iconPath: "assets/images/icon_chat.svg", 
        title: "رسالة جديدة من أحمد", 
        description: "لقد أرسل لك أحمد رسالة جديدة.",
         timeAgo: "قبل دقيقة",), 
          ]
        ),
      ),
      )
    );
  }
}
