import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  String selectedCondition = 'جديد';
  RangeValues priceRange = const RangeValues(20, 100);

  @override
  Widget build(BuildContext context) {
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
                child: const Text("Cancel"),
              ),
              const Text(
                "Filter",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCondition = 'جديد';
                    priceRange = const RangeValues(20, 100);
                  });
                },
                child: const Text("Reset"),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Product Condition
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "حالة المنتج",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          Column(
            children: [
              _buildRadio("جديد"),
              _buildRadio("مستعمل قليلاً"),
              _buildRadio("مستعمل كثيراً"),
              _buildRadio("قديم"),
            ],
          ),
          SizedBox(height: 16.h),

          // Price Range
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "نطاق السعر",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          RangeSlider(
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

          // Apply Button
          SizedBox(height: 12.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
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
            child: Text("مشاهدة ${widget.resultsCount} نتيجة"),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String label) {
    return RadioListTile<String>(
      title: Text(label, textAlign: TextAlign.right),
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
