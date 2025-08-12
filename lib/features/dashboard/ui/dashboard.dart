import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/dashboard/ui/widgets/header.dart';
import 'package:market_student/features/dashboard/ui/widgets/item_dashboard.dart';
import 'package:market_student/features/dashboard/ui/widgets/recent_transaction_item.dart';
import 'package:market_student/features/dashboard/ui/widgets/stats_card.dart';
import 'package:easy_localization/easy_localization.dart'; // لاستدعاء tr()

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DashboardHeader(
          title: tr('dashboard'),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              GridView.count(
                padding: EdgeInsets.symmetric(vertical: 16.h) ,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 1.3,
                children: [
                
                  StatsCard(
                    svgIcon: 'assets/images/profit.svg',
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
                    backgroundColor: colors.cards.withOpacity(0.8),
                    onTap: () {
                      context.push('/my_product_screen');
                    },
                  
                  ),
                  StatsCard(
                    svgIcon: 'assets/images/likes.svg',
                    title: tr('likes'),
                    count: "25",
                    backgroundColor: colors.red.withOpacity(0.2),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr('recent_transactions'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    tr('view_all'),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.green,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: ListView(
                  children: const [
                    RecentTransaction(
                      title: "كتاب العلوم و الدين",
                      price: "152 شيكل",
                      state: "تم البيع",
                      photo: "assets/images/books.png",
                      date: "2023-10-01",
                    ),
                    SizedBox(height: 12),
                    RecentTransaction(
                      title: "حاسوب محمول",
                      price: "2500 شيكل",
                      state: "تم البيع",
                      photo: "assets/images/books.png",
                      date: "2023-10-02",
                    ),
                    SizedBox(height: 12),
                    RecentTransaction(
                      title: "هاتف ذكي",
                      price: "1200 شيكل",
                      state: "تم البيع",
                      photo: "assets/images/books.png",
                      date: "2023-10-03",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
