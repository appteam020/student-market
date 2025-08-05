import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Image.asset('assets/images/google.png', height: 24.h),
      label: Text(
        'Google'.tr(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color:colors.textSecondary,
        ),
        
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 52.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}
