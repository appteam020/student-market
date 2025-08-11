import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/theme/colors.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String avatarPath;
  final VoidCallback onNotifications;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.avatarPath,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
         
          CircleAvatar(
            radius: 24.r,
            backgroundImage: AssetImage(avatarPath),
          ),
          SizedBox(width: 12.w),

         
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Text(
                  'hello_name'.tr(args: [userName]),
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  'استكشف أحدث المنتجات حولك',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:colors.textSecondary,
                      ),
                ),
              ],
            ),
          ),

         IconButton(
  onPressed: onNotifications,
  icon: SvgPicture.asset(
    'assets/images/notification.svg',
    width: 24.w,
    height: 24.h,
  ),
),
        ],
      ),
    );
  }
}
