import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/theme/colors.dart';

class ItemDashboard extends StatelessWidget {
  final String svgIcon;
  final String title;
  final String count;
  final Color backgroundColor; 

  const ItemDashboard({
    super.key,
    required this.svgIcon,
    required this.title,
    required this.count,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Container(
     
        decoration: BoxDecoration(
          color: backgroundColor, 
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SvgPicture.asset(
              svgIcon,
              height: 32.h,
              width: 32.w,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.textPrimary,
                  ),
            ),
            SizedBox(height:12.h),
            Text(
              count,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
