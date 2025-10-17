import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailsController extends ChangeNotifier {
  RequestState buyProductState = RequestState.init;
  void changeBuyProductState(RequestState state) {
    buyProductState = state;
    notifyListeners();
  }

  void buyProduct(BuildContext context, ProductModel productModel) async {
    changeBuyProductState(RequestState.loading);
    try {
      final changeProductStatus = await Supabase.instance.client
          .from('product_table')
          .update({'is_sold': true})
          .eq('id', productModel.id!);

      await Supabase.instance.client.from('sold').insert({
        'product': productModel.id,
        'buy_with': Supabase.instance.client.auth.currentUser!.id,
        'sold_with': productModel.user!.token,
      });

      customSnackBar(context, tr('product_bought_successfully'), Colors.green);
      Navigator.pop(context);
      GoRouter.of(context).go('/home');

      changeBuyProductState(RequestState.success);
    } on AuthException catch (e) {
      customSnackBar(context, tr('product_bought_error'), Colors.red);
      changeBuyProductState(RequestState.error);
    } on PostgrestException catch (e) {
      print(e);
      customSnackBar(context, tr('product_bought_error'), Colors.red);
      changeBuyProductState(RequestState.error);
    } catch (e) {
      print(e);
      customSnackBar(context, tr('product_bought_error'), Colors.red);
      changeBuyProductState(RequestState.error);
    }
  }

  RequestState shareProductState = RequestState.init;
  Future<void> shareProductWithImages(ProductModel product) async {
    shareProductState = RequestState.loading;
    notifyListeners();
    try {
      final dio = Dio();
      final tempDir = await getTemporaryDirectory();

      // 🟢 تحميل الصور من الإنترنت وتخزينها في مجلد مؤقت
      final downloadedImages = await Future.wait(
        product.image!.map((url) async {
          final fileName = url.split('/').last;
          final filePath = '${tempDir.path}/$fileName';
          final file = File(filePath);

          // تحميل الصورة
          final response = await dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes));

          await file.writeAsBytes(response.data!);
          return XFile(file.path);
        }),
      );

      // 🟢 إعداد بيانات المشاركة
      final params = ShareParams(subject: product.name, text: product.description ?? '', files: downloadedImages);

      // 🟢 مشاركة المنتج
      await SharePlus.instance.share(params);
      shareProductState = RequestState.success;
      notifyListeners();
    } catch (e) {
      shareProductState = RequestState.error;
      notifyListeners();
    }
  }
}
