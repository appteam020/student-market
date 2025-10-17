import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesProvider extends ChangeNotifier {
  List<ProductModel> favorites = [];
  RequestState favoritesState = RequestState.init;
  void changeFavoritesState(RequestState state) {
    favoritesState = state;
    notifyListeners();
  }

  String errorMessage = "";
  void getFavorites() async {
    changeFavoritesState(RequestState.loading);
    try {
      final response = await Supabase.instance.client
          .from('favorites')
          .select('*, product_table(*,tb_user(*))')
          .eq('user_id', Supabase.instance.client.auth.currentUser!.id);

      // طباعة النتيجة بشكل صحيح
      print("Fav List IS: $response");

      // تأكد إن response فعلاً List
      if (response is List) {
        favorites = response
            .where((e) => e['product_table'] != null)
            .map((e) => ProductModel.fromJson(e['product_table'] as Map<String, dynamic>))
            .toList();
      } else {
        favorites = [];
      }

      changeFavoritesState(RequestState.success);
    } catch (e, s) {
      print('❌ Error in getFavorites: $e');
      print('Stack: $s');
      errorMessage = e.toString();
      changeFavoritesState(RequestState.error);
    }
  }
}
