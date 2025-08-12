import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';

class EmptyProduct extends StatelessWidget {
   EmptyProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/box.svg',
          width: 120.w,
          height: 120.h,
        ),
        const SizedBox(height: 20),
        Text(

          tr("haven't_posted_product"),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colors.primary,
              ),
        ),
         SizedBox(height: 16.h),
        Text(
          tr("product_decription"),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height:24.h,),
        SizedBox(width: 300.w,
        child:CustomButton(
          onPressed: () => {},
          text: tr("add_new_product"),)
        )
        
      ],
    );
  }
}
