import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:provider/provider.dart';

class SearchProductCard extends StatelessWidget {
  final ProductModel model;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const SearchProductCard({super.key, required this.onTap, required this.onFavoriteTap, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/product_details', extra: model);
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 2, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(model.image![0], height: 100.h, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 8.h),

            Expanded(
              child: Text(
                model.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 4.h),
            Expanded(
              child: Text(
                model.description ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "\$ ${model.price}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
                ChangeNotifierProvider.value(
                  value: getIt<FavoritesController>(),
                  child: Consumer<FavoritesController>(
                    builder: (context, provider, child) {
                      return GestureDetector(
                        onTap: () {
                          if (provider.isFavorite(model.id!)) {
                            provider.removeFavorite(model.id!);
                          } else {
                            provider.addFavorite(model.id!);
                          }
                        },
                        child: Icon(
                          provider.isFavorite(model.id!) ? Icons.favorite : Icons.favorite_border,
                          color: true ? Colors.red : colors.textSecondary,
                          size: 18.sp,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
