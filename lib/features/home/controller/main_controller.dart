import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/features/add%20product/ui/upload_product_screen.dart';
import 'package:market_student/features/chats/ui/chats.dart';
import 'package:market_student/features/dashboard/ui/dashboard.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:market_student/features/home/ui/widgets/bottom_nav.dart';
import 'package:market_student/features/profile/ui/profile_screen.dart';

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;

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
