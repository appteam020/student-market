import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';

class ChangePassword extends StatelessWidget {
  final TextEditingController _passwordController =TextEditingController();
   ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: colors.cards,
      appBar: CustomAppBar(
        title:tr("change_pass"),
        onBack:() {},
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                      controller: _passwordController,
                      hint: 'Enter_current_pass'.tr(),
                      label: 'current_pass'.tr(),
                      
                      isPassword: true,
                       keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'invalid_password'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h,),
                     CustomTextField(
                      controller: _passwordController,
                      hint: 'Enter_new_password'.tr(),
                      label: 'new_pass'.tr(),
                      
                      isPassword: true,
                       keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'invalid_password'.tr();
                        }
                        return null;
                      },
                    ),
                  SizedBox(height: 16.h,),
                   CustomTextField(
                      controller: _passwordController,
                      hint: 'Re-enter_new_password'.tr(),
                      label: 'Confirm_new_password'.tr(),
                      
                      isPassword: true,
                       keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'invalid_password'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h,),
                    CustomButton(
                      text: tr("Update_password"),

                      onPressed: () => {})

            ]
          
          ),
        ),

    );
  }
}