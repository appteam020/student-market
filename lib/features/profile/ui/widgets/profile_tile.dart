import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/theme/colors.dart';

class ProfileOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(icon, color: iconColor ??colors.textPrimary,),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16.sp),
      
    );
  }
}
