import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/theme/colors.dart';

class NotificationCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final String timeAgo;

  const NotificationCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color:const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.r),
        
        boxShadow: [
          BoxShadow(
            color: colors.textSecondary.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 32.w,
            height: 32.w,
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                ),
              ],
            ),
          ),

          Center(
            child: Text(
              timeAgo,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
