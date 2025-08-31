import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/features/search/ui/widgets/bottom_sheet_filter.dart';
import 'package:market_student/features/search/ui/widgets/search_bar.dart';
import 'package:market_student/features/search/ui/widgets/search_product_card.dart';
import 'package:market_student/features/search/controller/search_prodvider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProdvider(),
      child: Consumer<SearchProdvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBarOnly(
                        controller: provider.searchController,
                        onChanged: (value) {
                          provider.getProducts();
                        },
                        onSearchTap: () {
                          provider.getProducts();
                        },
                        onFilterTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                            builder: (context) => FilterBottomSheet(provider: provider),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      Text(
                        "${provider.products.length} Item found for 'search term'",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                      SizedBox(height: 16.h),
                      GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.70),
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return SizedBox(
                            height: 200.h,
                            child: SearchProductCard(model: product, onFavoriteTap: () {}, onTap: () {}),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
