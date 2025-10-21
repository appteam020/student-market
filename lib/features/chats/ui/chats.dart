import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/chats/chat_screen/chat_screen.dart';
import 'package:market_student/features/chats/controller/chat_provider.dart';
import 'package:market_student/features/chats/ui/widgets/chat_card.dart';
import 'package:market_student/features/chats/ui/widgets/empty_chats.dart';
import 'package:provider/provider.dart';
import 'package:get_time_ago/get_time_ago.dart' as get_time_ago;

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ChangeNotifierProvider(
          create: (context) => ChatsProvider()
            ..getConversations()
            ..subscribeToConversations(),
          child: Consumer<ChatsProvider>(
            builder: (context, value, child) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final conversation = value.conversations[index];
                  if (value.conversations.isEmpty) {
                    return EmptyChats();
                  }
                  return ChatCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen(
                              chatProvider: value,
                              partnerId: conversation.partner.userId ?? '',
                              partnerName: conversation.partner.fullName,
                              onesignalId: conversation.partner.onesignalId ?? '',
                            );
                          },
                        ),
                      );
                    },

                    avatar: CircleAvatar(
                      backgroundColor: colors.primary.withValues(alpha: 0.3),
                      radius: 24.r,
                      backgroundImage: conversation.partner.profileImage == null
                          ? null
                          : NetworkImage(conversation.partner.profileImage ?? ''),
                      child: conversation.partner.profileImage == null ? Icon(Icons.person, color: colors.primary) : null,
                    ),
                    name: conversation.partner.fullName,
                    lastMessage: conversation.lastMessage,
                    time: get_time_ago.GetTimeAgo.parse(conversation.lastMessageTime, locale: context.locale.languageCode),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemCount: value.conversations.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
