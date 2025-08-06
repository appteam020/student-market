import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';

class EmptyFavarite extends StatelessWidget {
   EmptyFavarite({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/empty_favarite.svg',
          width: 150.w,
          height: 150.h,
        ),
        const SizedBox(height: 20),
        Text(
          tr("No_items_in_favorites"),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: colors.primary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          tr("favarite_decription"),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height:24.h,),
        SizedBox(width: 300.w,
        child:CustomButton(
          onPressed: () => {},
          text: " تصفح المنتجات ",)
        )
        
      ],
    );
  }
}
