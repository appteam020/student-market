
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/theme/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60.r,
          backgroundImage: NetworkImage(imageUrl),
        ),
        SizedBox(height: 16.h),
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8.h),
        Text(
          email,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        SizedBox(height: 8.h),
     InkWell(
  onTap: onEdit,
  borderRadius: BorderRadius.circular(8.r),
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      border: Border.all(
        color: colors.primary, // اللون الأخضر
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8.r),
      color: Colors.transparent, // بدون خلفية
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // يخلي حجم الزر وسط قد المحتوى
      children: [
        SvgPicture.asset(
          'assets/images/edit.svg',
          width: 20.w,
          height: 20.h,
          color: colors.primary,
        ),
        SizedBox(width: 8.w),
        Text(
          "تعديل الملف الشخصي",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.primary,
              ),
        ),
      ],
    ),
  ),
     )
    ]);
    

  }}