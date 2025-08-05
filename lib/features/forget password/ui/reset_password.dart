import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),

              // اللوجو
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 80.h,
                ),
              ),

              SizedBox(height: 32.h),

              // العنوان
              Text(
                'reset_password_title'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // الوصف
              Text(
                'reset_password_description'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32.h),

              // كلمة المرور الجديدة
              CustomTextField(
                label: 'new_password'.tr(),
                hint: 'enter_new_password'.tr(),
                controller: newPasswordController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),

              SizedBox(height: 16.h),

              // تأكيد كلمة المرور
              CustomTextField(
                label: 'confirm_password'.tr(),
                hint: 'reenter_password'.tr(),
                controller: confirmPasswordController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),

              SizedBox(height: 32.h),

              CustomButton(
                text: 'reset_password_button'.tr(),
                onPressed: () {
                
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
