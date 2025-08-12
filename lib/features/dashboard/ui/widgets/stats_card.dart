
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/theme/colors.dart';

class StatsCard extends StatelessWidget {
  final String svgIcon;
  final String title;
  final String count;
  final Color backgroundColor; 
    final VoidCallback? onTap; 


  const StatsCard({
        super.key,
    required this.svgIcon,
    required this.title,
    required this.count,
    required this.backgroundColor,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: backgroundColor,
       
        ),
         
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
        )),
    );

        
      
    
  }
}
