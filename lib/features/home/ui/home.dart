import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/add%20product/ui/upload_product_screen.dart';
import 'package:market_student/features/chats/ui/chats.dart';
import 'package:market_student/features/dashboard/ui/dashboard.dart';
import 'package:market_student/features/home/controller/main_controller.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:market_student/features/home/ui/build_small_product_item.dart';
import 'package:market_student/features/home/ui/widgets/bottom_nav.dart';
import 'package:market_student/features/profile/ui/profile_screen.dart';
import 'package:provider/provider.dart';
import 'widgets/home_header.dart';
import 'widgets/search_filter_bar.dart';
import 'widgets/category_chip.dart';
import 'widgets/offer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _categories = const [
    {'svg': 'assets/images/apps_svgrepo.com.svg', 'title': 'category_all'},
    {'svg': 'assets/images/book.svg', 'title': 'category_books'},
    {'svg': 'assets/images/clothes.svg', 'title': 'category_clothes'},
    {'svg': 'assets/images/devices.svg', 'title': 'category_electronics'},
    {'svg': 'assets/images/more-horizontal.svg', 'title': 'category_other'},
  ];

  int _selectedCategory = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                HomeHeader(
                  userName: tr('user_name'),
                  avatarPath: 'assets/images/user.png',
                  onNotifications: () => context.push('/notifications'),
                ),
                SizedBox(height: 24.h),
                SearchFilterBar(onFilterTap: () {}, onChanged: (q) {}),
                SizedBox(height: 24.h),
                Align(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      tr("section_categories"),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: colors.textPrimary),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Consumer<MainProvider>(
                  builder: (context, value, child) {
                    return SizedBox(
                      height: 90.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => SizedBox(width: 18.w),
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          return CategoryChip(
                            svgAsset: cat['svg']!,
                            title: tr(cat['title']!),
                            selected: index == _selectedCategory,
                            onTap: () {
                              _selectedCategory = index;
                              setState(() {});
                              value.getProducts(products: cat['title']!, context: context);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  height: 157.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      'assets/images/banner.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("section_featured_offers"),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: colors.textPrimary),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        tr('action_view_all'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
                      ),
                    ),
                  ],
                ),

                ChangeNotifierProvider.value(
                  value: getIt<MainProvider>(),
                  child: Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return SizedBox(
                        height: 100.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.model.length,
                          separatorBuilder: (_, __) => SizedBox(width: 12.w),
                          itemBuilder: (context, index) {
                            final product = value.model[index];
                            //  final isFav = _favoriteIndices.contains(index);
                            return OfferCard(
                              imagePath: product.image![0],
                              title: product.name.toString(),
                              price: product.price.toString(),

                              seller: product.user!.fullName.toString(),
                              onTap: () {
                                GoRouter.of(context).push("/product_details", extra: product);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('section_all_products'),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.textPrimary),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        tr('action_view_all'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Consumer<MainProvider>(
                  builder: (context, provider, child) {
                    switch (provider.productsState) {
                      case RequestState.init:
                      case RequestState.loading:
                        return Center(child: CircularProgressIndicator());
                      case RequestState.success:
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.model.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 22.h,
                            crossAxisSpacing: 22.w,
                            childAspectRatio: 0.58,
                          ),
                          itemBuilder: (context, index) {
                            return BuildSmallProductItem(product: provider.model[index]);
                          },
                        );
                      case RequestState.error:
                        return Column(
                          children: [
                            Icon(Icons.error),
                            SizedBox(height: 12),
                            Text("Some Error"),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                provider.getProducts(products: "all", context: context);
                              },
                              child: Text("Try Again"),
                            ),
                          ],
                        );
                    }
                  },
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
