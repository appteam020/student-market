import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/home/ui/widgets/product_card_small.dart';

class AllProductsSectionDesign extends StatelessWidget {
  final List<Map<String, dynamic>> products; // كل عنصر: { "title": ..., "price": ..., "imagePath": ..., "isFavorite": bool }
  final VoidCallback onViewAll;
  final void Function(int index) onProductTap;
  final void Function(int index) onFavoriteToggle;

  const AllProductsSectionDesign({
    super.key,
    required this.products,
    required this.onViewAll,
    required this.onProductTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        // Header with view all
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'جميع المنتجات',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text('مشاهدة الكل'),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Grid
        SizedBox(
          
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final p = products[index];
              return ProductCardSmall(
                imagePath: p['imagePath'] as String,
                title: p['title'] as String,
                price: p['price'] as String,
                isFavorite: p['isFavorite'] as bool? ?? false,
                onFavoriteTap: () => onFavoriteToggle(index),
                onTap: () => onProductTap(index),
              );
            },
          ),
        ),
      ],
    );
  }
}
