import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;
  final ValueChanged<String>? onChanged;

  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.onFilterTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search field (يمتد حتى قبل فلتر مع فاصل 24)
        Expanded(
          child: GestureDetector(
            onTap: () {
              // تنقل على شاشة البحث
              context.push('/search');
            },
            child: AbsorbPointer(
              // يخلي الحقل قابل للنقر لكنه لا يفتح لوحة المفاتيح لأننا ننتقل
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'ابحث عن منتج...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/images/search.svg',
                      width: 20.w,
                      height: 20.h,
                      semanticsLabel: 'search',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 8.w), // الفاصل المطلوب

        // Filter button
        SizedBox(
          height: 52.h,
          width: 52.h,
         
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgPicture.asset(
                'assets/images/filter.svg',
                width: 24.w,
                height: 24.h,
                semanticsLabel: 'filter',
              ),
            ),
          ),
        
      ],
    );
  }
}
