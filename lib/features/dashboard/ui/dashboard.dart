import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/core/theme/colors.dart';

import 'package:market_student/features/dashboard/ui/widgets/recent_transaction_item.dart';
import 'package:market_student/features/dashboard/ui/widgets/stats_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart'; // لاستدعاء tr()

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                GridView.count(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1.2,
                  children: [
                    StatsCard(
                      svgIcon: 'assets/images/profile.svg',
                      title: tr('total_profit'),
                      count: "1258 شيكل",
                      backgroundColor: colors.secondary.withOpacity(0.2),
                    ),
                    StatsCard(
                      svgIcon: 'assets/images/bag.svg',
                      title: tr('sold_products'),
                      count: "12",
                      backgroundColor: colors.primary.withOpacity(0.2),
                    ),
                    StatsCard(
                      svgIcon: 'assets/images/tag.svg',
                      title: tr('my_products'),
                      count: "2",
                      backgroundColor: colors.orange.withOpacity(0.2),
                      onTap: () {
                        context.push('/my_product_screen');
                      },
                    ),
                    ChangeNotifierProvider.value(
                      value: getIt<FavoritesController>(),
                      child: Consumer<FavoritesController>(
                        builder: (context, provider, child) {
                          return StatsCard(
                            svgIcon: 'assets/images/likes.svg',
                            title: tr('likes'),
                            count: provider.isLoading ? "0" : provider.favoriteProductIds.length.toString(),
                            backgroundColor: colors.red.withOpacity(0.2),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('recent_transactions'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(tr('view_all'), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green)),
                  ],
                ),
                SizedBox(height: 12.h),

                SizedBox(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: const [
                      RecentTransaction(
                        title: "كتاب العلوم و الدين",
                        price: "152 شيكل",
                        state: "تم البيع",
                        photo: "assets/images/books.png",
                        date: "2023-10-01",
                        color_state: 'notCompleted',
                      ),
                      SizedBox(height: 12),
                      RecentTransaction(
                        title: "حاسوب محمول",
                        price: "2500 شيكل",
                        state: "متاح حاليا",
                        photo: "assets/images/books.png",
                        date: "2023-10-02",
                        color_state: 'Completed',
                      ),
                      SizedBox(height: 12),
                      RecentTransaction(
                        title: "هاتف ذكي",
                        price: "1200 شيكل",
                        state: "متاح حاليا",
                        photo: "assets/images/books.png",
                        date: "2023-10-03",
                        color_state: 'Completed',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
