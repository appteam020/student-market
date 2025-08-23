import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HelpCenterController extends ChangeNotifier {
  TextEditingController questionController = TextEditingController();
  final formkey= GlobalKey<FormState>();
  RequestState requestState= RequestState.init;

  void changeState(RequestState s){
    requestState=s;
    notifyListeners();
  }

  void addQuestion(BuildContext context) async{
    try{
      if(formkey.currentState!.validate()){
        changeState(RequestState.loading);
       await Supabase.instance.client.from("help_center").insert({
          "question": questionController.text,
          "user_id": Supabase.instance.client.auth.currentUser!.id,
       
        }
        );
        changeState(RequestState.success);
        customSnackBar(context, "تم ارسال الاستفسار  ", colors.Completed);

      }
    }on PostgrestException catch (e){
      changeState(RequestState.error);
      customSnackBar(context, e.message, colors.red);

    }catch(e){
      changeState(RequestState.error);
      customSnackBar(context, e.toString(), colors.red);
    }

  }

}