import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final PageController controller;
  final int itemCount;

  const OnBoardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.controller,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            image,
            width: 354.w,
            height: 415.h,
            fit: BoxFit.cover,
          ),
        ),

        SizedBox(height: 12.h),

        // 👇 المؤشر هنا تحت الصورة مباشرة
        SmoothPageIndicator(
          controller: controller,
          count: itemCount,
          effect: ExpandingDotsEffect(
            activeDotColor: colors.primary,
            dotColor: colors.textSecondary,
            dotHeight: 8.h,
            dotWidth: 8.w,
            expansionFactor: 2.5,
            spacing: 6.w,
          ),
        ),

        SizedBox(height: 12.h),

        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
