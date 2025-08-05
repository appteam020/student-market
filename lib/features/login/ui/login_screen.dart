import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';
import 'package:market_student/features/login/ui/widgets/google_login_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32.h),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 80.h,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'welcome_back'.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'signin_to_continue'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    controller: _emailController,
                    hint: 'enter_email'.tr(),
                    label: 'email'.tr(),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'invalid_email'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  CustomTextField(
                    controller: _passwordController,
                    hint: 'enter_password'.tr(),
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
                 
                  Align(
                     alignment: context.locale.languageCode == 'ar'
                     ? Alignment.centerLeft // Align left for Arabic
                     : Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push('/forgot_password');
                      },
                      child: Text('forgot_password'.tr()
                      , style: TextStyle( color: colors.primary)),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomButton(
                    text: 'login'.tr(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.push('/home'); 
                        // Do login
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text('or_login_with'.tr()),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 24.h),
                   GoogleLoginButton(
                    onPressed: () {
                      // Handle Google login
                    },
              
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('no_account'.tr()
                      , style: TextStyle(color: colors.textSecondary)),
                      
                      TextButton(
                        onPressed: () => context.push('/signup'),
                        child: Text('signup'.tr()
                        , style: Theme.of(context).textTheme.bodyMedium?.
                        copyWith(color:colors.primary)),
                        )
                   
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
