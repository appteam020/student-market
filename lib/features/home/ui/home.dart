import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/home/ui/widgets/bottom_nav.dart';
import 'package:market_student/features/home/ui/widgets/productcard.dart';
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
  int _currentIndex = 0;

  final List<Map<String, String>> _products = List.generate(
    8,
    (i) => {
      'title_key': 'product_media_law_book',
      'price_key': 'product_price_example',
      'seller_key': 'user_name',
      'image': 'assets/images/product.png',
    },
  );

  final Set<int> _favoriteIndices = {};

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSmallProductCard(int index) {
    final product = _products[index];
    final isFav = _favoriteIndices.contains(index);
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: Image.asset(
                product['image']!,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(product['title_key']!),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr(product['price_key']!),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colors.primary),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isFav) {
                              _favoriteIndices.remove(index);
                            } else {
                              _favoriteIndices.add(index);
                            }
                          });
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : colors.textSecondary,
                          size: 18.sp,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        items: [
          BottomNavItemData(asset: 'assets/images/home.svg', label: tr('nav_home')),
          BottomNavItemData(asset: 'assets/images/dashboard.svg', label: tr('nav_dashboard')),
          BottomNavItemData(asset: 'assets/images/plus-circle.svg', label: tr('nav_add_product')),
          BottomNavItemData(asset: 'assets/images/chats.svg', label: tr('nav_chats')),
          BottomNavItemData(asset: 'assets/images/profile.svg', label: tr('nav_profile')),
        ],
      ),
      body: SafeArea(
        child: Padding(
          
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                HomeHeader(
                  userName: tr('user_name'),
                  avatarPath: 'assets/images/user.png',
                  onNotifications: () => context.push('/notifications'),
                ),
                SizedBox(height: 24.h),
                SearchFilterBar(
                  controller: _searchController,
                  onFilterTap: () {},
                  onChanged: (q) {},
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    tr("section_categories"),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
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
                        onTap: () => setState(() => _selectedCategory = index),
                      );
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  height: 157.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                SizedBox(height: 24.h),

                // قسم العروض المميزة باستخدام OfferCard
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("section_featured_offers"),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        tr('action_view_all'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
            
                SizedBox(
                  height:100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      final isFav = _favoriteIndices.contains(index);
                      return OfferCard(
                        imagePath: product['image']!,
                        title: tr(product['title_key']!),
                        price: tr(product['price_key']!),
                      
                        seller: tr(product['seller_key']!),
                        onTap: () {},
                      );
                    },
                  ),
                ),

                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('section_all_products'),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        tr('action_view_all'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    return _buildSmallProductCard(index);
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
