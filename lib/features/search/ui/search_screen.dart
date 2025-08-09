import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/features/search/ui/widgets/bottom_sheet_filter.dart';
import 'package:market_student/features/search/ui/widgets/search_bar.dart';
import 'package:market_student/features/search/ui/widgets/search_product_card.dart';
class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;

  List<String> recentSearches = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
  ];

  final List<Map<String, String>> _products = List.generate(
    8,
    (i) => {
      'title_key': 'product_media_law_book',
      'price_key': 'product_price_example',
      'seller_key': 'user_name',
      'image': 'assets/images/product.png',
    },
  );

  late List<bool> isFavoriteList;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    isFavoriteList = List.generate(_products.length, (_) => false);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarOnly(
                  controller: searchController,
                  onChanged: (value) {},
                  onSearchTap: () {},
               onFilterTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => FilterBottomSheet(
                      resultsCount: 25,
                      onApply: (filters) {
                        print("تم تطبيق الفلتر: $filters");
                      },
                    ),
                  );
                },

                ),
                SizedBox(height: 16.h),
                /*
                Text(
                  tr("Recently_Searched"),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      return RecentSearchItem(
                        text: recentSearches[index],
                        onTap: () {},
                        onDelete: () {},
                      );
                    },
                  ),
                )
                */

                Text(
                  tr("3 Item found for 'search term'"),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
                SizedBox(height: 16.h),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return SearchProductCard(
                      imagePath: product['image']!,
                      title: tr(product['title_key']!),
                      price: tr(product['price_key']!),
                      isFavorite: isFavoriteList[index],
                      onFavoriteTap: () {
                        setState(() {
                          isFavoriteList[index] = !isFavoriteList[index];
                        });
                      },
                      onTap: () {
                        // التنقل لتفاصيل المنتج مثلاً
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}
