import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/utils/app_assets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/on_boarding_model.dart';
import 'widgets/on_boarding _body.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnBoardingModel> items = [
    OnBoardingModel(
      image: Assets.assetsImagesOnboarding1,
      title: 'title1'.tr(),
      description: 'body1'.tr(),
    ),
    OnBoardingModel(
      image: Assets.assetsImagesOnboarding2,
      title: 'title2'.tr(),
      description: 'body2'.tr(),
    ),
    OnBoardingModel(
      image: Assets.assetsImagesOnboarding3,
      title: 'title3'.tr(),
      description: 'body3'.tr(),
    ),
  ];

  void _nextPage() {
    if (_currentPage == items.length - 1) {
      context.go('/login');
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_currentPage + 1} ${'from'.tr()} ${items.length}'),
                        GestureDetector(
                          onTap: () => context.go('/home'),
                          child: Text('skip'.tr(), style: TextStyle(color: colors.primary)),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: items.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          final item = items[index];
                         return OnBoardingItem(
                          image: item.image,
                          title: item.title,
                          description: item.description,
                          controller: _pageController,
                          itemCount: items.length,
                        );
                                    },
                      ),
                    ),
                    SizedBox(height: 12.h),
                 
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    _currentPage == items.length - 1 ? 'start'.tr() : 'Next'.tr(),
                    style: const TextStyle(color: colors.background),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
