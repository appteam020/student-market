import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:market_student/features/home/ui/build_small_product_item.dart';
import 'package:market_student/features/home/ui/widgets/productcard.dart';

class ViewAllFeatruredOffers extends StatelessWidget {
  const ViewAllFeatruredOffers({super.key, required this.title, required this.products});
  final String title;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: tr(title)),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return BuildSmallProductItem(product: products[index]);
        },

        itemCount: products.length,
      ),
    );
  }
}
