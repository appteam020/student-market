import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBarOnly extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSearchTap;

  const SearchBarOnly({
    super.key,
    required this.controller,
    this.onChanged,
    this.onFilterTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: (_) => onSearchTap?.call(), 
            decoration: InputDecoration(
              hintText: 'ابحث عن منتج...',
              prefixIcon: GestureDetector(
                onTap: onSearchTap,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SvgPicture.asset(
                    'assets/images/search.svg',
                    width: 20.w,
                    height: 20.h,
                    semanticsLabel: 'search',
                    color: Theme.of(context).iconTheme.color,
                  ),
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
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onFilterTap,
          child: SizedBox(
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
        ),
      ],
    );
  }
}
