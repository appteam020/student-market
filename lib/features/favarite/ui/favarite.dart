import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/favarite/ui/widgets/empty_favarite.dart';
import 'package:market_student/features/favarite/ui/widgets/favarite_card.dart';

class Favarite extends StatelessWidget {
   Favarite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: tr("Favorites")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          //child: EmptyFavarite(),
            child: ListView.separated(
            itemCount: 3, // عددي حسب المنتجات
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return FavariteCard(
                photo: 'assets/images/product.png',
                title: 'تيشيرت نايك شبابي',
                price: '\$99.99',
                iconPath: 'assets/images/favarite.svg',
                state: 'متاح',
              );
            },
          ),
        ),
      ),
    );
  }
}