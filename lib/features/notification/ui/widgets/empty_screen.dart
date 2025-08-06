import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/theme/colors.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/notifications.svg',
            width: 150.w,
            height: 150.h,
          ),
          const SizedBox(height: 20),
          Text(
            tr("No_new_notifications"),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: colors.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            tr("notification_decription"),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
