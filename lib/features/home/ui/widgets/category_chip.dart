import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/theme/colors.dart';
class CategoryChip extends StatelessWidget {
  final String? svgAsset; 
  final IconData? iconData; 
  final String title;
  final VoidCallback onTap;
  final bool selected;

  // ألوان جديدة للـ selected/unselected
  final Color? selectedBackgroundColor;
  final Color? selectedIconColor;
  final Color? unselectedBackgroundColor;
  final Color? unselectedIconColor;

  const CategoryChip({
    super.key,
    this.svgAsset,
    this.iconData,
    required this.title,
    required this.onTap,
    this.selected = false,
    this.selectedBackgroundColor,
    this.selectedIconColor,
    this.unselectedBackgroundColor,
    this.unselectedIconColor,
  }) : assert(svgAsset != null || iconData != null, 'Either svgAsset or iconData must be provided');

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = selected
        ? (selectedBackgroundColor ?? colors.primary)
        : (unselectedBackgroundColor ?? Colors.grey.shade200);

    final Color iconColor = selected
        ? (selectedIconColor ?? colors.background)
        : (unselectedIconColor ?? Colors.grey.shade600);

    final Color textColor = selected
        ? (selectedBackgroundColor != null ? selectedBackgroundColor! : Theme.of(context).primaryColor)
        : (unselectedIconColor != null ? unselectedIconColor! : Colors.grey.shade800);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: selected ? backgroundColor : Colors.transparent, width: 2),
            ),
            child: Center(
              child: svgAsset != null
                  ? SvgPicture.asset(
                      svgAsset!,
                      width: 24.w,
                      height: 24.w,
                      color: iconColor,
                      semanticsLabel: title,
                    )
                  : Icon(
                      iconData,
                      size: 28.sp,
                      color: iconColor,
                    ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}