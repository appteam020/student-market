import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/chats/ui/widgets/chat_card.dart';
import 'package:market_student/features/chats/ui/widgets/empty_chats.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      appBar: CustomAppBar(
        title:tr("Chats"),

        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
     
          children: [
           // EmptyChats(), 
        ChatCard(
  avatar: CircleAvatar(
    radius: 24.r,
    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=1"),
  ),
  name: "Ahmed Ali",
  lastMessage: " Hello, how are you?",
  time: "min ago",
),

      ChatCard(
  avatar: CircleAvatar(
    radius: 24.r,
    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=1"),
  ),
  name: "Sara Ahmed",
  lastMessage: " Let's meet tomorrow",
  time: " 2 min ago",
),
        
      ] ),
      ),

    );
  }}