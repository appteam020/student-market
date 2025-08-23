import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RequestState signUpState = RequestState.init;
  String errorMessage = '';

  void changeRequestState(RequestState state) {
    signUpState = state;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      changeRequestState(RequestState.loading);
      try {
        final response = await Supabase.instance.client.auth.signUp(
          email: emailController.text,
          password: passwordController.text,
        );

        if (response.user != null) {
          await Supabase.instance.client.from('tb_user').insert({
            'full_name': fullNameController.text,
            'email': emailController.text,
            'user_id': response.user!.id,
          });
          customSnackBar(context, 'تم التسجيل بنجاح', colors.Completed);
          context.pop();
          changeRequestState(RequestState.success); // عند النجاح
        } else {
          changeRequestState(RequestState.error); // عند الفشل
          Supabase.instance.client.auth.signOut();
        }
      } on AuthException catch (e) {
        errorMessage = e.message;
        customSnackBar(context, e.message, colors.red);
        changeRequestState(RequestState.error);
      } on PostgrestException catch (e) {
        errorMessage = e.message;
        customSnackBar(context, e.message, colors.red);
        changeRequestState(RequestState.error);
      } on Exception catch (e) {
        errorMessage = e.toString();
        customSnackBar(context, errorMessage, colors.red);
        changeRequestState(RequestState.error);
      } catch (e) {
        errorMessage = e.toString();
        customSnackBar(context, errorMessage, colors.red);
        changeRequestState(RequestState.error);
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
