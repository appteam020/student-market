import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProdvider extends ChangeNotifier {
  List<ProductModel> products = [];
  RequestState searchResultState = RequestState.init;
  TextEditingController searchController = TextEditingController();

  String selectedCondition = 'new';
  RangeValues priceRange = const RangeValues(20, 100);
  void changeSelectedCondition(String condition) {
    selectedCondition = condition;
    notifyListeners();
  }

  void changePriceRange(RangeValues range) {
    priceRange = range;
    notifyListeners();
  }

  void getProducts() async {
    searchResultState = RequestState.loading;
    notifyListeners();
    try {
      print(searchController.text);
      // Change is on this line: use .ilike() instead of .contains()
      final response = await Supabase.instance.client
          .from('product_table')
          .select('*,tb_user(*)')
          .ilike('name', '%${searchController.text}%'); // ✨ The corrected line
      if (response.isNotEmpty) {
        products = response.map((toElement) {
          print(toElement);
          return ProductModel.fromJson(toElement);
        }).toList();
      }

      print(products.length);
      searchResultState = RequestState.success;
      notifyListeners();
    } on PostgrestException catch (e) {
      print(e.message);
      searchResultState = RequestState.error;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      searchResultState = RequestState.error;
      notifyListeners();
    }
  }

  int get resultsCount => products.length;
}
