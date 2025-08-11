import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:market_student/core/theme/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  final int resultsCount;
  final Function(Map<String, dynamic>) onApply;

  const FilterBottomSheet({
    super.key,
    required this.resultsCount,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedCondition = 'new'.tr();
  RangeValues priceRange = const RangeValues(20, 100);

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "cancel".tr(),
                  style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "filter".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: colors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCondition = 'new'.tr();
                    priceRange = const RangeValues(20, 100);
                  });
                },
                child: Text(
                  "reset".tr(),
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Product Condition
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              "product_condition".tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: colors.textPrimary,
              ),
            ),
          ),
          Column(
            children: [
              _buildRadio("new".tr()),
              _buildRadio("slightly_used".tr()),
              _buildRadio("heavily_used".tr()),
              _buildRadio("old".tr()),
            ],
          ),
          SizedBox(height: 16.h),

          // Price Range Title
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "price_range".tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: colors.textPrimary,
                  ),
                ),
                 Text(
              "${'current_price'.tr(args: [
                priceRange.start.round().toString(),
                priceRange.end.round().toString()
              ])}",
              style: TextStyle(
                fontSize: 14.sp,
                color: colors.textSecondary,
              ),
            ),
              ],
            ),
          ),


          RangeSlider(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey.shade300,
            values: priceRange,
            min: 5,
            max: 500,
            divisions: 100,
            labels: RangeLabels(
              "\$${priceRange.start.round()}",
              "\$${priceRange.end.round()}",
            ),
            onChanged: (RangeValues values) {
              setState(() {
                priceRange = values;
              });
            },
          ),

       
          SizedBox(height: 12.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              widget.onApply({
                'condition': selectedCondition,
                'priceRange': priceRange,
              });
              Navigator.of(context).pop();
            },
            child: Text(
              "view_results".tr(args: [widget.resultsCount.toString()]),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String label) {
  return RadioListTile<String>(
    contentPadding: EdgeInsets.zero, 
    dense: true, 
    activeColor: Theme.of(context).primaryColor,
    title: Text(
      label,
      style: const TextStyle(color: colors.textPrimary),
    ),
    value: label,
    groupValue: selectedCondition,
    onChanged: (value) {
      setState(() {
        selectedCondition = value!;
      });
    },
  );
}
}