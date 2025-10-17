import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:market_student/features/profile/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends ChangeNotifier {
  ProfileModel? profile;
  RequestState profileState = RequestState.init;
  RequestState stateUploadImage = RequestState.init;
  String errorMessage = "";
  File? file;
  void stateMangement(RequestState state) {
    profileState = state;
    notifyListeners();
  }

  void stateUploadImageMangement(RequestState state) {
    stateUploadImage = state;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future<void> getProfile({bool isLoading = true}) async {
    final response = Supabase.instance.client;
    if (isLoading) stateMangement(RequestState.loading);
    try {
      final user = await response.auth.getUser();
      if (user.user != null) {
        final data = await response.from('tb_user').select('*').eq('user_id', user.user!.id).single();
        profile = ProfileModel().fromJson(data);
        stateMangement(RequestState.success);
      } else {
        stateMangement(RequestState.error);
      }
    } on AuthException catch (e) {
      errorMessage = e.message;
      stateMangement(RequestState.error);
    } on PostgrestException catch (e) {
      errorMessage = e.message;
      stateMangement(RequestState.error);
    } catch (e) {
      errorMessage = e.toString();
      stateMangement(RequestState.error);
    }
  }

  Future<void> updateProfileImage(BuildContext context) async {
    try {
      stateUploadImageMangement(RequestState.loading);
      final supabase = Supabase.instance.client;
      final user = await supabase.auth.getUser();

      final imageName = "${DateTime.now().millisecondsSinceEpoch}${file!.path.split('/').last}";
      final image = await supabase.storage.from('profile_images').upload(imageName, file!);

      final imageUrl = supabase.storage.from('profile_images').getPublicUrl(imageName);
      print(imageUrl); // طباعة الرابط للتأكد

      if (user.user != null) {
        // تحديث الصورة في قاعدة البيانات
        final response = await supabase.from('tb_user').update({'image': imageUrl}).eq('user_id', user.user!.id);
        getProfile(isLoading: false);
        stateMangement(RequestState.success);
      }

      stateUploadImageMangement(RequestState.success);
      customSnackBar(context, tr('profile_image_updated_successfully'), colors.primary);
      Navigator.of(context).pop();
      file = null;
    } on AuthException catch (e) {
      customSnackBar(context, tr('profile_image_updated_error'), Colors.red);
      stateUploadImageMangement(RequestState.error);
    } on PostgrestException catch (e) {
      customSnackBar(context, tr('profile_image_updated_error'), Colors.red);
      stateUploadImageMangement(RequestState.error);
    } on StorageException catch (e) {
      customSnackBar(context, tr('profile_image_updated_error'), Colors.red);
      stateUploadImageMangement(RequestState.error);
    } catch (e) {
      print(e);
      customSnackBar(context, tr('profile_image_updated_error'), Colors.red);
      stateUploadImageMangement(RequestState.error);
    }
  }

  TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RequestState editProfileName = RequestState.init;
  void initialValue(String name) {
    nameController.text = name;
    notifyListeners();
  }

  void updateProfileName(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      editProfileName = RequestState.loading;
      notifyListeners();

      try {
        final supabase = Supabase.instance.client;
        final user = await supabase.auth.getUser();
        final response = await supabase.from('tb_user').update({'full_name': nameController.text}).eq('user_id', user.user!.id);
        getProfile(isLoading: false);
        editProfileName = RequestState.success;
        notifyListeners();
        customSnackBar(context, tr('update_profile_name_successfully'), colors.primary);
        context.pop();
        nameController.clear();
      } catch (e) {
        editProfileName = RequestState.error;
        notifyListeners();
        customSnackBar(context, tr('update_profile_name_error'), Colors.red);
        context.pop();
      }
    }
  }
}
