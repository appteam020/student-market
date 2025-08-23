import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/login/controller/signup_controller.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';
import 'package:market_student/features/login/ui/widgets/google_login_button.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      body: ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
        child: Consumer<SignUpProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: provider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 32.h),
                        Center(child: Image.asset('assets/images/logo.png', height: 80.h)),
                        SizedBox(height: 24.h),
                        Text(
                          'create_account'.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'signup_description'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32.h),
                        CustomTextField(
                          controller: provider.fullNameController,
                          hint: 'enter_full_name'.tr(),
                          label: 'full_name'.tr(),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'invalid_full_name'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          controller: provider.emailController,
                          hint: 'enter_email'.tr(),
                          label: 'email'.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'invalid_email'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          controller: provider.passwordController,
                          hint: 'create_password'.tr(),
                          label: 'password'.tr(),
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
                          controller: provider.confirmPasswordController,
                          hint: 'reenter_password'.tr(),
                          label: 'confirm_password'.tr(),
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != provider.passwordController.text) {
                              return 'passwords_not_match'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        provider.signUpState == RequestState.loading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: 'signup'.tr(),
                                onPressed: () async {
                                  await context.read<SignUpProvider>().signUp(context);
                                },
                              ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text('or'.tr()),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        GoogleLoginButton(onPressed: () {}),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'have_account'.tr(),
                              style: TextStyle(color: colors.textSecondary)?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () => context.go('/login'),
                              child: Text(
                                'login'.tr(),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(color: colors.primary)?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
