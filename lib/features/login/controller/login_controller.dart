import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RequestState loginState = RequestState.init;
  String errorMessage = "";

  void stateMangement(RequestState state) {
    loginState = state;
    notifyListeners();
  }

  Future login(BuildContext context) async {
    stateMangement(RequestState.loading);
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        password: passwordController.text,
        email: emailController.text,
      );
      customSnackBar(context, 'تم تسجيل الدخول بنجاح', colors.primary);
      context.go('/inital_screen');
      stateMangement(RequestState.success);
    } on AuthException catch (e) {
      errorMessage = e.message;
      customSnackBar(context, e.message, colors.red);
      stateMangement(RequestState.error);
    } catch (e) {
      errorMessage = e.toString();
      customSnackBar(context, errorMessage, colors.red);
      stateMangement(RequestState.error);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
