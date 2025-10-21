import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/notification/controller/notifications_procider.dart';
import 'package:market_student/features/notification/ui/widgets/empty_screen.dart';
import 'package:market_student/features/notification/ui/widgets/notification_card.dart';
import 'package:provider/provider.dart';
import 'package:get_time_ago/get_time_ago.dart' as get_time_ago;

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: tr("notifications"), onBack: () => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ChangeNotifierProvider.value(
          value: getIt<NotificationsProvider>()..getNotifications(),
          child: Consumer<NotificationsProvider>(
            builder: (context, provider, child) {
              switch (provider.notificationsState) {
                case RequestState.init:
                case RequestState.loading:
                  return const Center(child: CircularProgressIndicator());
                case RequestState.success:
                  if (provider.notifications.isEmpty) {
                    return const EmptyScreen();
                  }
                  return ListView.builder(
                    itemCount: provider.notifications.length,
                    itemBuilder: (context, index) {
                      final item = provider.notifications[index];
                      return NotificationCard(
                        iconPath: "assets/images/icon_chat.svg",
                        description: "${tr("new_message_from")} ${item.sender.fullName}",
                        title: "${tr("you_have_a_new_message")} ",
                        timeAgo: get_time_ago.GetTimeAgo.parse(item.created, locale: context.locale.languageCode),
                      );
                    },
                  );
                case RequestState.error:
                  return const Center(child: Text("Error"));
              }
            },
          ),
        ),
      ),
    );
  }
}
