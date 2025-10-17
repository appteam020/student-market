import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  RequestState searchResultState = RequestState.init;
  TextEditingController searchController = TextEditingController();

  String selectedCondition = 'New';
  RangeValues priceRange = const RangeValues(0, 20);

  /// 🟢 تغيير حالة المنتج
  void changeSelectedCondition(String condition) {
    selectedCondition = condition;
    notifyListeners();
  }

  /// 🟢 تغيير مدى السعر
  void changePriceRange(RangeValues range) {
    priceRange = range;
    notifyListeners();
  }

  /// 🟢 جلب المنتجات بناءً على الشروط
  Future<void> getProducts() async {
    searchResultState = RequestState.loading;
    notifyListeners();

    try {
      print('Min price: ${priceRange.start}');
      print('Max price: ${priceRange.end}');
      print('Status: ${selectedCondition.trim().toLowerCase()}');

      /// 🔹 بناء الاستعلام الأساسي
      var query = Supabase.instance.client
          .from('product_table')
          .select('*, tb_user(*)')
          .gte('price', priceRange.start.round())
          .lte('price', priceRange.end.round());

      /// 🔹 إضافة البحث بالاسم فقط إذا كان المستخدم كتب شيئًا
      if (searchController.text.trim().isNotEmpty) {
        query = query.ilike('name', '%${searchController.text.trim()}%'); // ✅ ilike بدل eq
      }

      /// 🔹 إضافة الفلترة بالحالة فقط إذا كانت غير فارغة
      if (selectedCondition.trim().isNotEmpty) {
        query = query.eq('status', selectedCondition.toLowerCase().trim()); // ✅ eq لأن الحالة تطابق دقيق
      }

      /// 🔹 تنفيذ الاستعلام
      final response = await query;

      /// 🔹 التعامل مع النتائج
      if (response.isNotEmpty) {
        products = (response as List).map((e) => ProductModel.fromJson(e)).toList();
      } else {
        products = [];
      }

      print('Products count: ${products.length}');
      searchResultState = RequestState.success;
    } on PostgrestException catch (e) {
      print('PostgrestException: ${e.message}');
      searchResultState = RequestState.error;
    } catch (e) {
      print('Error: $e');
      searchResultState = RequestState.error;
    }

    notifyListeners();
  }

  /// 🟢 عدد النتائج
  int get resultsCount => products.length;
}
