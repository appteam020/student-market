import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/theme/colors.dart';

import 'package:market_student/features/login/ui/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({super.key, required this.email});
  final String email;
  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final int codeLength = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(codeLength, (_) => TextEditingController());
    focusNodes = List.generate(codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      body: Consumer(
        builder: (context, value, child) {
          return SafeArea(
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
                  Text('verify_title'.tr(), style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                  SizedBox(height: 8.h),

                  // الوصف
                  Text('verify_description'.tr(), style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),

                  SizedBox(height: 32.h),

                  // خانات رمز التحقق
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(codeLength, (index) {
                      return SizedBox(
                        width: 50.w,
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.sp),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < codeLength - 1) {
                                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            }
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.primary, width: 2),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 32.h),

                  // زر المتابعة
                  CustomButton(
                    text: 'continue'.tr(),
                    onPressed: () {
                      String otp = "";
                      for (var controller in controllers) {
                        otp += controller.text;
                      }
                      context.push('/reset_password', extra: {'otp': otp, 'email': widget.email});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
