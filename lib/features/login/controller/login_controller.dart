import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:market_student/features/login/service/google_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
    stateMangement(RequestState.loading);

    try {
      final response = await GoogleSignInService.signInWithGoogle();
      if (response != null) {
        customSnackBar(context, tr('login_successfully'), colors.primary);
        String uniqueId = genrateUniqueId();

        await Supabase.instance.client.from('tb_user').update({'onesignal_id': uniqueId}).eq('user_id', response.user!.id);
        OneSignal.login(uniqueId);
        context.go('/home');
        stateMangement(RequestState.success);
      } else {
        googleErrorMessage = tr('login_cancelled');
        stateMangement(RequestState.error);
      }
    } catch (e) {
      googleErrorMessage = e.toString();
      stateMangement(RequestState.error);
    }
  }

  String genrateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
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
      context.go('/home');
      String uniqueId = genrateUniqueId();

      await Supabase.instance.client.from('tb_user').update({'onesignal_id': uniqueId}).eq('user_id', response.user!.id);
      OneSignal.login(uniqueId);
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
