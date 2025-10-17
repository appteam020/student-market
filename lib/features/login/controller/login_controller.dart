import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:market_student/features/login/service/google_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RequestState loginState = RequestState.init;
  String errorMessage = "";
  RequestState googleLoginState = RequestState.init;
  String googleErrorMessage = "";
  Future<void> googleLogin(BuildContext context) async {
    googleLoginState = RequestState.loading;
    notifyListeners();
    try {
      final response = await GoogleSignInService.signInWithGoogle();
      if (response != null) {
        customSnackBar(context, tr('login_successfully'), colors.primary);
        context.go('/inital_screen');
        googleLoginState = RequestState.success;
      } else {
        googleErrorMessage = tr('login_cancelled');
        googleLoginState = RequestState.error;
      }
    } catch (e) {
      googleErrorMessage = e.toString();
    }
  }

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
      customSnackBar(context, tr('login_successfully'), colors.primary);
      context.go('/inital_screen');
      stateMangement(RequestState.success);
    } on AuthException catch (e) {
      errorMessage = e.message;
      customSnackBar(context, tr('login_error'), colors.red);
      stateMangement(RequestState.error);
    } catch (e) {
      errorMessage = e.toString();
      customSnackBar(context, tr('login_error'), colors.red);
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
