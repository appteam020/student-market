import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/add%20product/ui/widgets/inpu_filed.dart';
import 'package:market_student/features/add%20product/ui/widgets/upload_photo.dart';
import 'package:market_student/features/home/ui/widgets/category_chip.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final List<Map<String, String>> categories = const [

    {'svg': 'assets/images/book.svg', 'title': 'category_books'},
    {'svg': 'assets/images/clothes.svg', 'title': 'category_clothes'},
    {'svg': 'assets/images/devices.svg', 'title': 'category_electronics'},
    {'svg': 'assets/images/more-horizontal.svg', 'title': 'category_other'},
  ];

  int selectedCategory = 0;
  String productCondition = 'new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      appBar: CustomAppBar(
        title: tr("add_product"),
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            UploadImageBox(onTap: () {}),
            SizedBox(height: 16.h),

            CustomTextField(
              label: tr("product_name"),
              hint: tr("enter_product_name"),
              controller: TextEditingController(),
            ),
            SizedBox(height: 16.h),

            CustomTextField(
              label: tr("product_description"),
              hint: tr("enter_product_description"),
              type: 'description',
              controller: TextEditingController(),
                
            ),
            SizedBox(height: 16.h),

            CustomTextField(
              label: tr("product_price"),
              hint: tr("enter_product_price"),
              controller: TextEditingController(),
              type: 'price',
             
            ),
            SizedBox(height: 16.h),

            Text(
              tr("section_categories"),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 90.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 18.w),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return CategoryChip(
                    svgAsset: cat['svg']!,
                    title: tr(cat['title']!),
                    selected: index == selectedCategory,
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              tr("product_condition"),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
            ),
            _buildConditionOption("new", tr("new")),
            _buildConditionOption("slightly_used", tr("slightly_used")),
            _buildConditionOption("heavily_used", tr("heavily_used")),
            _buildConditionOption("old", tr("old")),

            SizedBox(height: 16.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                },
                child: Text(
                  tr("publish_product"),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildConditionOption(String value, String label) {
  return Padding(
    padding: EdgeInsets.zero, 
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: productCondition,
          onChanged: (val) {
            setState(() {
              productCondition = val!;
            });
          },
        ),
        SizedBox(width: 4.w), 
        Text(label, style: const TextStyle(color: colors.textPrimary)),
      ],
    ),
  );
}
}