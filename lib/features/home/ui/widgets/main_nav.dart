import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/features/add%20product/ui/upload_product_screen.dart';
import 'package:market_student/features/chats/ui/chats.dart';
import 'package:market_student/features/dashboard/ui/dashboard.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:market_student/features/home/ui/widgets/bottom_nav.dart';
import 'package:market_student/features/profile/ui/profile_screen.dart';
class MainNavigation extends StatelessWidget {
  final Widget child;
  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) currentIndex = 0;
    else if (location.startsWith('/dashboard')) currentIndex = 1;
    else if (location.startsWith('/add_product')) currentIndex = 2;
    else if (location.startsWith('/chats')) currentIndex = 3;
    else if (location.startsWith('/profile_screen')) currentIndex = 4;

    final items = [
      BottomNavItemData(asset: 'assets/images/home.svg', label: tr('nav_home')),
      BottomNavItemData(asset: 'assets/images/dashboard.svg', label: tr('nav_dashboard')),
      BottomNavItemData(asset: 'assets/images/plus-circle.svg', label: tr('nav_add_product')),
      BottomNavItemData(asset: 'assets/images/chats.svg', label: tr('nav_chats')),
      BottomNavItemData(asset: 'assets/images/profile.svg', label: tr('nav_profile')),
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: HomeBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/dashboard');
          if (index == 2) context.go('/add_product');
          if (index == 3) context.go('/chats');
          if (index == 4) context.go('/profile_screen');
        },
        items: items,
      ),
    );
  }
}
