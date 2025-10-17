import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductController extends ChangeNotifier {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQuantityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RequestState addProductState = RequestState.init;
  void stateMangementState(RequestState state) {
    addProductState = state;
    notifyListeners();
  }

  List<File> images = [];

  Future<void> pickImage(BuildContext context) async {
    images = [];

    final pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages != null && pickedImages.length <= 3) {
      images.addAll(pickedImages.map((e) => File(e.path)));
    } else {
      customSnackBar(context, tr('you_can_only_select_3_images'), Colors.red);
    }
    notifyListeners();
  }

  void removeImage(File image) {
    images.remove(image);
    notifyListeners();
  }

  void addProduct(BuildContext context, String selectedCategory, String status) async {
    if (images.isEmpty) {
      customSnackBar(context, tr('you_must_select_an_image'), Colors.red);
      return;
    } else if (formKey.currentState!.validate()) {
      try {
        stateMangementState(RequestState.loading);
        final supabase = Supabase.instance.client;
        final user = supabase.auth.currentUser;
        final imageUrls = await uploadImage();
        final product = {
          'name': productNameController.text,
          'description': productDescriptionController.text,
          'price': int.parse(productPriceController.text),
          'quantity': 1,
          "user": user?.id,
          "images": imageUrls,
          "category": selectedCategory,
          "status": status,
          'is_sold': false,
        };
        final response = await supabase.from('product_table').insert(product).select();
        if (response.isNotEmpty) {
          customSnackBar(context, tr('product_added_successfully'), Colors.green);
          productNameController.clear();
          productDescriptionController.clear();
          productPriceController.clear();
          images.clear();
          formKey.currentState!.reset();
          stateMangementState(RequestState.success);
        } else {
          customSnackBar(context, tr('failed_to_add_product'), Colors.red);
          stateMangementState(RequestState.error);
        }
      } on AuthException catch (e) {
        customSnackBar(context, e.message, Colors.red);
      } on PostgrestException catch (e) {
        customSnackBar(context, e.message, Colors.red);
      } catch (e) {
        print(e);
        customSnackBar(context, tr('failed_to_add_product'), Colors.red);
      }
    }
  }

  Future<List<String>> uploadImage() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    final List<String> imageUrls = [];

    try {
      for (var image in images) {
        final path = "${DateTime.now().millisecondsSinceEpoch}${image.path.split('/').last}";
        final imageFile = File(image.path);

        final response = await supabase.storage.from('product_images').upload(path, imageFile);

        // استخدم path فقط بدون إضافة مجلد 'product_images' مرة أخرى
        final imageUrl = await supabase.storage.from('product_images').getPublicUrl(path);
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print("Error: $e");
    }

    return imageUrls;
  }
}
