import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/home/model/product_model.dart';

class RecentTransaction extends StatelessWidget {
  final ProductModel product;

  const RecentTransaction({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.r),

        boxShadow: [BoxShadow(color: colors.textSecondary.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(imageUrl: product.image![0], width: 85.w, height: 85.h, fit: BoxFit.cover),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: colors.textPrimary),
                ),
                SizedBox(height: 24.h),

                Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.tryParse(product.createdAt.toString()) ?? DateTime.now()),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "${product.price} ${tr('product_price_dollar')}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: product.isSold == true ? colors.Completed : colors.notCompleted,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  product.isSold == true ? tr('completed') : tr('not_completed'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
