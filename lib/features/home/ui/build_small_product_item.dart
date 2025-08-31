import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:provider/provider.dart';

import '../../../core/di/get_it.dart';

class BuildSmallProductItem extends StatelessWidget {
  const BuildSmallProductItem({Key? key, required this.product}) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/product_details", extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
              child: Image.network(product.image![0], height: 150.h, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "البائع :${product.user?.fullName}",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colors.primary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product.price} ${tr('product_price_dollar')}",
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                      ),
                      ChangeNotifierProvider.value(
                        value: getIt<FavoritesController>(),
                        child: Consumer<FavoritesController>(
                          builder: (context, provider, child) {
                            return GestureDetector(
                              onTap: () {
                                if (provider.isFavorite(product.id!)) {
                                  provider.removeFavorite(product.id!);
                                } else {
                                  provider.addFavorite(product.id!);
                                }
                              },
                              child: Icon(
                                provider.isFavorite(product.id!) ? Icons.favorite : Icons.favorite_border,
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
          ],
        ),
      ),
    );
  }
}
