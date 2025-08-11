
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/features/dashboard/ui/widgets/header.dart';
import '../widgets/stats_card.dart';
import '../widgets/recent_transaction_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardHeader(),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: الإحصائيات
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 1.3,
              children: const [
                StatsCard(
                  title: "المنتجات المعروضة",
                  value: "26",
                  icon: Icons.shopping_bag,
                ),
                StatsCard(
                  title: "الأرباح الإجمالية",
                  value: "1258 شيكل",
                  icon: Icons.attach_money,
                ),
                StatsCard(
                  title: "الإعجابات",
                  value: "265",
                  icon: Icons.favorite,
                ),
                StatsCard(
                  title: "منتجات معلقة",
                  value: "3",
                  icon: Icons.warning_amber,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // Section 2: المعاملات الأخيرة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "المعاملات الأخيرة",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "عرض الكل",
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
                  RecentTransactionItem(
                    title: "كتاب العلوم و الدين",
                    price: "152 شيكل",
                    status: "تم البيع",
                    imageUrl: "assets/images/book.png",
                    date: "2023-10-01",
                  ),
                  RecentTransactionItem(
                    title: "سماعات سوني",
                    price: "152 شيكل",
                    status: "تم البيع",
                    imageUrl: "assets/images/headphones.png",
                    date: "2023-10-01",
                  ),
                  RecentTransactionItem(
                    title: "حقيبة كتف",
                    price: "152 شيكل",
                    status: "تم البيع",
                    imageUrl: "assets/images/bag.png",
                    date: "2023-10-01",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "ملفي الشخصي"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "إشعار بيع"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "لوحة التحكم"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "المتجر"),
        ],
      ),
    );
  }
}
