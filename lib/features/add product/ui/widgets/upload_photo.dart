import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class UploadImageBox extends StatelessWidget {
  final VoidCallback onTap;

  const UploadImageBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        options: CustomPathDottedBorderOptions(
          padding: EdgeInsets.all(32.0),
          color: colors.primary,
          strokeWidth: 2,
          dashPattern: const [8, 4],
          customPath: (size) {
            final rect = Rect.fromLTWH(0, 0, size.width, size.height);
            final radius = Radius.circular(12.r);
            return Path()..addRRect(RRect.fromRectAndRadius(rect, radius));
          },
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 140.h,
            color: colors.cards,
            child: Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Image.asset(
                "assets/images/photo.png",
                width: 60.w,
                height: 60.h,
          
                ),
                SizedBox(height: 10.h),
                Text(
                  tr("titile_photo"),
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16.sp,
                   
                  
                    
                  ),
                ),
                 SizedBox(height: 10.h),
                Text(
                  tr("upload_photo"),
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14.sp,
                    
                  ),
                ),
               ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
