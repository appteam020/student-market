import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  RequestState changePasswordState = RequestState.init;
  String errorMessage = "";

  void stateManagement(RequestState state) {
    changePasswordState = state;
    notifyListeners();
  }

  // تغيير كلمة المرور
  Future changePassword(BuildContext context) async {
    stateManagement(RequestState.loading);

    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      errorMessage = tr('passwords_do_not_match');
      customSnackBar(context, errorMessage, colors.red);
      stateManagement(RequestState.error);
      return;
    }

    try {
      final user = Supabase.instance.client.auth.currentUser;
      final response = await Supabase.instance.client.auth.signInWithPassword(email: user!.email!, password: oldPassword);

      if (response.user == null) {
        errorMessage = tr('old_password_is_incorrect');
        customSnackBar(context, errorMessage, colors.red);
        stateManagement(RequestState.error);
        return;
      }

      // تحديث كلمة المرور
      await Supabase.instance.client.auth.updateUser(UserAttributes(password: newPassword));

      customSnackBar(context, tr('password_changed_successfully'), colors.primary);
      stateManagement(RequestState.success);
      await Supabase.instance.client.auth.signOut();
      context.go('/login');
    } on AuthException catch (e) {
      errorMessage = e.message;
      customSnackBar(context, errorMessage, colors.red);
      stateManagement(RequestState.error);
    } catch (e) {
      errorMessage = e.toString();
      customSnackBar(context, errorMessage, colors.red);
      stateManagement(RequestState.error);
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
