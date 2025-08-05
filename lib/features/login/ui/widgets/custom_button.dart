import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
       
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
        backgroundColor:colors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text(text, style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: colors.background,
        )),
      ),
    );
  }
}
