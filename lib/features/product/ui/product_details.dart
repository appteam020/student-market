import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/home/model/product_model.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int seletectImage = 0;
  toggleImage(int index) {
    setState(() {
      seletectImage = index;
    });
  }

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
                    Image.network(
                      widget.productModel.image![seletectImage],
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
                          ChangeNotifierProvider.value(
                            value: getIt<FavoritesController>(),
                            child: Consumer<FavoritesController>(
                              builder: (context, provider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    if (provider.isFavorite(widget.productModel.id!)) {
                                      provider.removeFavorite(widget.productModel.id!);
                                    } else {
                                      provider.addFavorite(widget.productModel.id!);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: colors.cards, shape: BoxShape.circle),
                                    child: Icon(
                                      provider.isFavorite(widget.productModel.id!) ? Icons.favorite : Icons.favorite_border,
                                      color: provider.isFavorite(widget.productModel.id!) ? Colors.red : colors.textSecondary,
                                      size: 20.sp,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: colors.cards, shape: BoxShape.circle),
                              child: SvgPicture.asset('assets/images/Back.svg', height: 20.h, width: 20.w, color: colors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productModel.image!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => toggleImage(index),
                        child: Container(
                          margin: EdgeInsets.only(right: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: seletectImage == index ? colors.primary : colors.textSecondary, width: 4),
                          ),
                          child: Image.network(widget.productModel.image![index], width: 50.w, height: 50.h, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                // معلومات المنتج
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel.name ?? "",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '\$ ${widget.productModel.price}',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          tr("Staus:"),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.productModel.status ?? "",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: colors.textSecondary, fontWeight: FontWeight.bold),
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
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '${widget.productModel.description}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),
                    Divider(color: colors.textSecondary.withOpacity(0.5), thickness: 1, height: 16.h),

                    Row(
                      children: [
                        CircleAvatar(radius: 24.r, backgroundImage: NetworkImage(widget.productModel.user?.profileImage ?? "")),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${tr("saller")}: ${widget.productModel.user?.fullName}',

                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text('فلسطين', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textSecondary)),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            icon: SvgPicture.asset('assets/images/chat.svg', height: 20.h, width: 20.w, color: Colors.white),
                            label: Text(tr("Contact_the_seller"), style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              side: BorderSide(color: colors.primary, width: 1.5),
                            ),
                            icon: Icon(Icons.share, color: colors.primary),
                            label: Text(tr("share_with_friend"), style: TextStyle(color: colors.primary)),
                          ),
                        ),
                      ],
                    ),
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
