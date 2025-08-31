import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchFilterBar extends StatelessWidget {
  final VoidCallback onFilterTap;
  final ValueChanged<String>? onChanged;

  const SearchFilterBar({super.key, required this.onFilterTap, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: TextField(
              onChanged: onChanged,
              onTap: () {
                context.push('/search_screen');
              },
              decoration: InputDecoration(
                hintText: tr('search'),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
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
      ],
    );
  }
}
