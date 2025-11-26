import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/dashboard/controller/dashboard_controller.dart';

import 'package:market_student/features/dashboard/ui/widgets/recent_transaction_item.dart';
import 'package:market_student/features/dashboard/ui/widgets/stats_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:market_student/features/view_all_featrured_offers/view_all_featrured_offers.dart';
import 'package:provider/provider.dart'; // لاستدعاء tr()

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.w),
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
                  ChangeNotifierProvider(
                    create: (context) =>
                        DashboardController()..getMySoldProducts(),
                    child: Consumer<DashboardController>(
                      builder:
                          (
                            BuildContext context,
                            DashboardController value,
                            Widget? child,
                          ) {
                            return StatsCard(
                              svgIcon: 'assets/images/profile.svg',
                              title: tr('total_profit'),
                              count:
                                  "${value.totalProfit} ${tr('product_price_dollar')}",
                              backgroundColor: colors.secondary.withOpacity(
                                0.2,
                              ),
                            );
                          },
                    ),
                  ),
                  ChangeNotifierProvider(
                    create: (context) =>
                        DashboardController()..getMySoldProducts(),
                    child: Consumer<DashboardController>(
                      builder:
                          (
                            BuildContext context,
                            DashboardController value,
                            Widget? child,
                          ) {
                            return StatsCard(
                              svgIcon: 'assets/images/bag.svg',
                              title: tr('sold_products'),
                              count:
                                  value.mySoldProductsState ==
                                      RequestState.loading
                                  ? "Loading..."
                                  : value.mySoldProducts.length.toString(),
                              backgroundColor: colors.primary.withOpacity(0.2),
                            );
                          },
                    ),
                  ),
                  ChangeNotifierProvider(
                    create: (context) =>
                        DashboardController()..getMyCurrentPdoucts(),
                    child: Consumer<DashboardController>(
                      builder: (context, provider, child) {
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              '/my_product_screen',
                              extra: provider.myCurrentProducts,
                            );
                          },
                          child: StatsCard(
                            svgIcon: 'assets/images/tag.svg',
                            title: tr('my_products'),
                            count:
                                provider.myCurrentProductsState ==
                                    RequestState.loading
                                ? "Loading..."
                                : provider.myCurrentProducts.length.toString(),
                            backgroundColor: colors.orange.withOpacity(0.2),
                            onTap: () {
                              context.push(
                                '/my_product_screen',
                                extra: provider.myCurrentProducts,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  ChangeNotifierProvider.value(
                    value: getIt<FavoritesController>(),
                    child: Consumer<FavoritesController>(
                      builder: (context, provider, child) {
                        return StatsCard(
                          onTap: () {
                            context.push('/favorites');
                          },
                          svgIcon: 'assets/images/likes.svg',
                          title: tr('likes'),
                          count: provider.isLoading
                              ? "0"
                              : provider.favoriteProductIds.length.toString(),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ChangeNotifierProvider.value(
                    value: getIt<DashboardController>()..getMySoldProducts(),

                    child: Consumer<DashboardController>(
                      builder: (context, value, child) {
                        return value.mySoldProducts.isNotEmpty
                            ? TextButton(
                                onPressed: value.mySoldProducts.isNotEmpty
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAllFeatruredOffers(
                                                  title: tr(
                                                    'section_all_products',
                                                  ),
                                                  products:
                                                      value.mySoldProducts,
                                                ),
                                          ),
                                        );
                                      }
                                    : null,
                                style: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(
                                    Colors.green,
                                  ),
                                ),
                                child: Text(tr('view_all')),
                              )
                            : Container();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              Expanded(
                child: ChangeNotifierProvider.value(
                  value: getIt<DashboardController>()..getMySoldProducts(),

                  child: Consumer<DashboardController>(
                    builder: (context, value, child) {
                      switch (value.mySoldProductsState) {
                        case RequestState.init:
                        case RequestState.loading:
                          return Center(child: CircularProgressIndicator());
                        case RequestState.success:
                          if (value.mySoldProducts.isEmpty) {
                            return Center(
                              child: Text(tr("No_transactions_found")),
                            );
                          }
                          return ListView.builder(
                            //  shrinkWrap: true,
                            itemCount: value.mySoldProducts.length > 5
                                ? 5
                                : value.mySoldProducts.length,
                            itemBuilder: (context, index) {
                              return RecentTransaction(
                                product: value.mySoldProducts[index],
                              );
                            },
                          );
                        case RequestState.error:
                          return Center(
                            child: Text(tr("Something went wrong")),
                          );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
