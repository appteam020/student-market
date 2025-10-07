import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardController extends ChangeNotifier {
  List<ProductModel> myCurrentProducts = [];
  RequestState myCurrentProductsState = RequestState.init;
  Future<void> getMyCurrentPdoucts() async {
    print("asdvtest");
    myCurrentProductsState = RequestState.loading;
    notifyListeners();
    try {
      final response = await Supabase.instance.client
          .from('product_table')
          .select('*,tb_user(*)')
          .eq('user', Supabase.instance.client.auth.currentUser!.id);
      myCurrentProducts = response.map((e) => ProductModel.fromJson(e)).toList();
      print("asd${myCurrentProducts.length}");
      myCurrentProductsState = RequestState.success;
      notifyListeners();
    } catch (e) {
      print("asd${e}");
      myCurrentProductsState = RequestState.error;
      notifyListeners();
    }
  }
}
