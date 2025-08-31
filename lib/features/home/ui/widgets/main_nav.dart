import 'package:flutter/material.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/home/controller/main_controller.dart';
import 'package:market_student/features/home/ui/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;
  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<MainProvider>()..getProducts(products: "all", context: context),
      child: Consumer<MainProvider>(
        builder: (BuildContext context, MainProvider value, Widget? child) {
          return Scaffold(
            appBar: (value.currentIndex != 0)
                ? AppBar(
                    centerTitle: true,
                    title: Text(
                      value.title(context)[value.currentIndex],
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
            body: value.screens[value.currentIndex],
            bottomNavigationBar: HomeBottomNav(
              currentIndex: value.currentIndex,
              onTap: (index) {
                value.setCurrentIndex(index);
              },
              items: value.items(context),
            ),
          );
        },
      ),
    );
  }
}
