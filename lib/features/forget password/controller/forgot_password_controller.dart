import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final tokenController = TextEditingController();
  RequestState forgotPasswordState = RequestState.init;
  RequestState resetPasswordState = RequestState.init;
  String errorMessage = "";
  void changeRequestState(RequestState state) {
    forgotPasswordState = state;
    notifyListeners();
  }

  void changeResetPasswordState(RequestState state) {
    resetPasswordState = state;
    notifyListeners();
  }

  Future<void> forgotPassword(BuildContext context) async {
    changeRequestState(RequestState.loading);
    if (formKey.currentState!.validate()) {
      try {
        final response = await Supabase.instance.client.auth.resetPasswordForEmail(emailController.text);
        customSnackBar(context, 'تم إرسال كود إعادة تعيين كلمة المرور', colors.primary);
        changeRequestState(RequestState.success);
        context.push('/otp', extra: emailController.text); // إنتقل إلى صفحة إدخال الـ OTP
      } catch (e) {
        errorMessage = e.toString();
        customSnackBar(context, errorMessage, colors.red);
        changeRequestState(RequestState.error);
      }
    }
  }

  Future<void> otpConfirmation(BuildContext context, String otp, String newPassword, String email) async {
    changeResetPasswordState(RequestState.loading);

    try {
      final response = await Supabase.instance.client.auth.verifyOTP(type: OtpType.recovery, email: email, token: otp);

      // إذا تم التحقق بنجاح، قم بإعادة تعيين كلمة المرور
      await confirmNewPassword(context, newPassword);
    } on AuthException catch (e) {
      errorMessage = e.message;
      customSnackBar(context, errorMessage, colors.red);
      changeResetPasswordState(RequestState.error);
    } catch (e) {
      errorMessage = e.toString();
      customSnackBar(context, errorMessage, colors.red);
      changeResetPasswordState(RequestState.error);
    }
  }

  Future<void> confirmNewPassword(BuildContext context, String newPassword) async {
    changeResetPasswordState(RequestState.loading);
    try {
      final response = await Supabase.instance.client.auth.updateUser(UserAttributes(password: newPassword));
      customSnackBar(context, 'تم إعادة تعيين كلمة المرور', colors.primary);
      changeResetPasswordState(RequestState.success);
      context.push('/login'); // إعادة توجيه المستخدم إلى صفحة تسجيل الدخول
    } on AuthException catch (e) {
      errorMessage = e.message;
      customSnackBar(context, errorMessage, colors.red);
      changeResetPasswordState(RequestState.error);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
