import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RequestState loginState= RequestState.init;
  String errorMessage="";

   void stateMangement(RequestState state){
    loginState= state;
    notifyListeners();
  }
  

  Future login() async{
    stateMangement(RequestState.loading);
    try{
      final response=
     await Supabase.instance.client.auth.signInWithPassword(
        password: passwordController.text,
        email: emailController.text,
        );
        stateMangement(RequestState.success);
    } on AuthException catch (e){
      errorMessage= e.message;
      stateMangement(RequestState.error);
     } 
    catch (e){
       errorMessage= e.toString();
       stateMangement(RequestState.error);
    }

  


  }



}