import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/forget%20password/controller/forgot_password_controller.dart';

import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      appBar: AppBar(foregroundColor: colors.primary),
      body: ChangeNotifierProvider(
        create: (context) => ForgotPasswordController(),
        child: Consumer<ForgotPasswordController>(
          builder: (context, value, child) {
            return SafeArea(
              child: Form(
                key: value.formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80.h),

                      // اللوجو
                      Center(child: Image.asset('assets/images/logo.png', height: 80.h)),

                      SizedBox(height: 32.h),

                      // العنوان
                      Text(
                        'forget_password_title'.tr(), // مثلاً: "نسيت كلمة المرور؟"
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),

                      // الوصف
                      Text(
                        'forget_password_description'.tr(), // "لا تقلق! أدخل بريدك وسنرسل رابط إعادة تعيين كلمة المرور."
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 32.h),

                      // حقل البريد الإلكتروني
                      CustomTextField(
                        label: 'email'.tr(),
                        hint: 'enter_email'.tr(),
                        controller: value.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'invalid_email'.tr();
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 32.h),

                      // زر الإرسال
                      value.forgotPasswordState == RequestState.loading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              text: 'send_recovery_link'.tr(),
                              onPressed: () async {
                                await value.forgotPassword(context);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
