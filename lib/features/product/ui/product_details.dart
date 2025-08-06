import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/theme/colors.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            
            child: Column(
              children: [
            
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/product.png',
                      width: double.infinity,
                      height: 350.h,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 16.h,
                      right: 16.w,
                      left: 16.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/favarite.svg',
                                height: 20.h,
                                width: 20.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/Back.svg',
                                height: 20.h,
                                width: 20.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            
                SizedBox(height: 16.h),
            
                // معلومات المنتج
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تيشيرت نايك شبابي - مقاس M',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '\$99.99',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          tr("Staus:"),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'شبه جديد',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: colors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
            
                    // الوصف
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('product_description'),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'اللون: أبيض\nالنوع: قطن\nتم استخدامه فقط مرتين\nلا يوجد أي شق أو بقع\nمناسب لطلاب الجامعات أو الاستخدام اليومي',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: colors.textSecondary,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
            
                    SizedBox(height: 8.h),
                    Divider(
                      color: colors.textSecondary.withOpacity(0.5),
                      thickness: 1,
                      height: 16.h,
                    ),
            
               
                    Row(
                      children: [
                     
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("saller") + ': هشام الفائز',
                         
                              style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                            Text(
                              'فلسطين',
                              style:
                                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: colors.textSecondary,
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
            
                    SizedBox(height: 16.h),
            
                  
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                        
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            icon: SvgPicture.asset(
                              'assets/images/chat.svg',
                              height: 20.h,
                              width: 20.w,
                              color: Colors.white,
                            ),
                            label: Text(
                              tr("Contact_the_seller"),
                              style: TextStyle(
                               
                                color: Colors.white,
                              ),
                          ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                             
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              side: BorderSide(
                                color: colors.primary,
                                width: 1.5,
                              ),
                            ),
                            icon: Icon(Icons.share,
                            color: colors.primary,),
                            label: Text(
                              tr("share_with_friend")  ,
                            style: TextStyle(
                              color: colors.primary,),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
