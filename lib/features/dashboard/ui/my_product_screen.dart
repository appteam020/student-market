import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // تأكد من استيراد الحزمة الصحيحة
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/dashboard/ui/widgets/header.dart';
import 'package:market_student/features/dashboard/ui/widgets/recent_transaction_item.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': "كتاب العلوم و الدين",
        'price': "152 شيكل",
        'state': "تم البيع",
        'photo': "assets/images/books.png",
        'date': "2023-10-01",
        'color_state': 'notCompleted'
      },
      {
        'title': "حاسوب محمول",
        'price': "2500 شيكل",
        'state': "متاح حاليا",
        'photo': "assets/images/books.png",
        'date': "2023-10-02",
        'color_state': 'Completed'
      },
      {
        'title': "هاتف ذكي",
        'price': "1200 شيكل",
        'state': "متاح حاليا",
        'photo': "assets/images/books.png",
        'date': "2023-10-03",
        'color_state': 'Completed'
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: DashboardHeader(title: tr('My_Products')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: Key(item['title']!),
                background: Container(
                  color: colors.orange,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset(
                    'assets/images/edit.svg',
                    height: 32.h,
                    width: 32.w,
                 
                  ),
                ),
                secondaryBackground: Container(
                  color: colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تعديل: ${item['title']}')),
                    );
                  } else {
                    // سحب من اليمين لليسار → حذف
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم حذف: ${item['title']}')),
                    );
                  }
                },
                child: RecentTransaction(
                  title: item['title']!,
                  price: item['price']!,
                  state: item['state']!,
                  photo: item['photo']!,
                  date: item['date']!,
                  color_state: item['color_state']!,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
