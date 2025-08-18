import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/add%20product/ui/widgets/inpu_filed.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      appBar: CustomAppBar(title: tr("Help_Center"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("Help_Center_title"),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.textPrimary
                ),
              ),
              SizedBox(height: 8.h,),
                  Text(
                  tr('help_center_descripiton'),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary
                ),
              ),
           
                CustomTextField(
                label:"",
                hint: tr('helpcenter_hint'),
                type: 'description',
                controller: TextEditingController(),
                  
              ),
              SizedBox(height: 16.h,),
              CustomButton(text: tr("Send_question"), onPressed:(){})
          
            ],
                ),
        )),

    );
  }
}