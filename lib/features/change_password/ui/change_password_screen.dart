import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/change_password/controller/change_password_controller.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordProvider(),
      child: Consumer<ChangePasswordProvider>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: colors.cards,
            appBar: CustomAppBar(
              title: tr("change_pass"),
              onBack: () {
                context.pop();
              },
            ),
            body: Form(
              key: value.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: value.oldPasswordController,
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
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: value.newPasswordController,
                      hint: 'Enter_new_password'.tr(),
                      label: 'new_pass'.tr(),

                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text.length < 6) {
                          return 'invalid_password'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: value.confirmPasswordController,
                      hint: 'Re-enter_new_password'.tr(),
                      label: 'Confirm_new_password'.tr(),

                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text.length < 6) {
                          return 'invalid_password'.tr();
                        }
                        if (text != value.newPasswordController.text) {
                          return 'password_not_match'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    value.changePasswordState == RequestState.loading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            text: tr("Update_password"),
                            onPressed: () {
                              if (value.formKey.currentState!.validate()) {
                                value.changePassword(context);
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
