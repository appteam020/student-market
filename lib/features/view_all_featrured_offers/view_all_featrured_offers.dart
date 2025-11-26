import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:market_student/features/home/ui/build_small_product_item.dart';
import 'package:market_student/features/home/ui/widgets/productcard.dart';

class ViewAllFeatruredOffers extends StatelessWidget {
  const ViewAllFeatruredOffers({
    super.key,
    required this.title,
    required this.products,
  });
  final String title;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    // 2. تحديد عدد الأعمدة بناءً على العرض
    // يمكنك تغيير هذه الأرقام حسب ما تراه مناسبًا
    int crossAxisCount;
    if (screenWidth > 600) {
      crossAxisCount = 4; // 4 أعمدة للشاشات الكبيرة (الجهاز اللوحي)
    } else if (screenWidth > 400) {
      crossAxisCount = 3; // 3 أعمدة للشاشات المتوسطة
    } else {
      crossAxisCount = 2; // 2 عمود للشاشات الصغيرة (الهاتف)
    }
    return Scaffold(
      appBar: CustomAppBar(title: tr(title)),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            // **maxCrossAxisExtent**: الحد الأقصى لعرض كل عنصر (بالبكسل).
            // اختر 200.0 كقيمة معيارية: على الشاشات الكبيرة، ستتمكن من رؤية
            // 3 أو 4 أعمدة، وعلى الشاشات الصغيرة، عمودين.
            maxCrossAxisExtent: 200.0,

            // **childAspectRatio**: نسبة الطول إلى العرض لكل عنصر (الطول / العرض).
            // القيمة 1 / 1.5 تجعل العنصر أطول قليلاً، وهو مناسب عادةً لكروت المنتجات.
            childAspectRatio: 1 / 1.5,

            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            // ... باقي الكود
            return BuildSmallProductItem(product: products[index]);
          },

          itemCount: products.length,
        ),
      ),
    );
  }
}
