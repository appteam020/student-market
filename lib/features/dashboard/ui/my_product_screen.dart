import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // تأكد من استيراد الحزمة الصحيحة
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/dashboard/ui/widgets/header.dart';
import 'package:market_student/features/dashboard/ui/widgets/recent_transaction_item.dart';
import 'package:market_student/features/home/model/product_model.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true, title: Text(tr('my_products')), foregroundColor: colors.textPrimary),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = products[index];
              return Dismissible(
                key: Key(item.name!),
                background: Container(
                  color: colors.red,
                  alignment: AlignmentDirectional.centerEnd, // تحديد الموضع إلى نهاية الاتجاه
                  padding: EdgeInsetsDirectional.only(end: 24.w), // إضافة مسافة من النهاية
                  child: const Icon(Icons.delete, size: 32, color: Colors.white),
                ),

                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تعديل: ${item['title']}')));
                  }
                },
                child: RecentTransaction(
                  title: item.name!,
                  price: item.price!.toString(),
                  state: item.status!,
                  photo: item.image![0],
                  date: item.createdAt!.toString(),
                  color_state: item.status!,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
