import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/favorites_page/controller/favorites_provider.dart';
import 'package:market_student/features/home/ui/build_small_product_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: tr("favorites")),
      body: ChangeNotifierProvider.value(
        value: getIt<FavoritesProvider>()..getFavorites(),
        child: Consumer<FavoritesProvider>(
          builder: (context, provider, child) {
            switch (provider.favoritesState) {
              case RequestState.init:
              case RequestState.loading:
                return Center(child: CircularProgressIndicator());
              case RequestState.success:
                if (provider.favorites.isEmpty) {
                  return Center(child: Text("You don't have any favorites"));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: provider.favorites.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 0.5,
                      maxCrossAxisExtent: 250,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      final product = provider.favorites[index];

                      if (provider.favorites[index].isSold == true) {
                        return Banner(
                          message: 'sold'.tr(),
                          location: BannerLocation.topStart,
                          child: BuildSmallProductItem(product: product),
                        );
                      }
                      return BuildSmallProductItem(product: product);
                    },
                  ),
                );
              case RequestState.error:
                return Center(child: Text(provider.errorMessage));
            }
          },
        ),
      ),
    );
  }
}
