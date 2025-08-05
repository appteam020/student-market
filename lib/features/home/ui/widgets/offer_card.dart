import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class OfferCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const OfferCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.onFavoriteTap,
    required this.onTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصورة
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Image.asset(
                  imagePath,
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color:colors.primary),
                        ),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : colors.textSecondary,
                            size: 20.sp,
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
      ),
    );
  }
}
