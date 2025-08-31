import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/widget/custom_snackbar.dart';
import 'package:market_student/features/add%20product/ui/upload_product_screen.dart';
import 'package:market_student/features/chats/ui/chats.dart';
import 'package:market_student/features/dashboard/ui/dashboard.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:market_student/features/home/ui/widgets/bottom_nav.dart';
import 'package:market_student/features/profile/ui/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<ProductModel> model = [];
  RequestState productsState = RequestState.init;
  void changeProductsState(RequestState state) {
    productsState = state;
    notifyListeners();
  }

  String productType = 'all';
  void getProducts({required String products, required BuildContext context}) async {
    changeProductsState(RequestState.loading);
    productType = products;
    print(products);
    if (products == "all" || products == "category_all") {
      try {
        final response = await Supabase.instance.client.from("product_table").select("*,tb_user(*)");
        print(response);
        model = response.map((e) => ProductModel.fromJson(e)).toList();
        print(model.length);
        changeProductsState(RequestState.success);
      } on PostgrestException catch (e) {
        print(e.message);
        //  customSnackBar(context, e.message, Colors.red);
        changeProductsState(RequestState.error);
        print(e);
      } catch (e) {
        print(e.toString());
        //  customSnackBar(context, e.toString(), Colors.red);
        changeProductsState(RequestState.error);
      }
    } else {
      try {
        final response = await Supabase.instance.client.from("product_table").select("*,tb_user(*)").eq("category", products);
        model = response.map((e) => ProductModel.fromJson(e)).toList();
        changeProductsState(RequestState.success);
      } on PostgrestException catch (e) {
        customSnackBar(context, e.message, Colors.red);
        changeProductsState(RequestState.error);
        print(e);
      } catch (e) {
        customSnackBar(context, e.toString(), Colors.red);
        changeProductsState(RequestState.error);
      }
    }
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const HomeScreen(),
    const DashboardScreen(),
    UploadProductScreen(),
    const Chats(),
    const ProfileScreen(),
  ];
  List<String> title(BuildContext context) => [
    tr('nav_home'),
    tr('nav_dashboard'),
    tr('nav_add_product'),
    tr('nav_chats'),
    tr('nav_profile'),
  ];
  List<BottomNavItemData> items(BuildContext context) => [
    BottomNavItemData(asset: 'assets/images/home.svg', label: context.tr('nav_home')),
    BottomNavItemData(asset: 'assets/images/dashboard.svg', label: context.tr('nav_dashboard')),
    BottomNavItemData(asset: 'assets/images/plus-circle.svg', label: context.tr('nav_add_product')),
    BottomNavItemData(asset: 'assets/images/chats.svg', label: context.tr('nav_chats')),
    BottomNavItemData(asset: 'assets/images/profile.svg', label: context.tr('nav_profile')),
  ];
}
