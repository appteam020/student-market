import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/features/add%20product/ui/upload_product_screen.dart';
import 'package:market_student/features/chats/ui/chats.dart';
import 'package:market_student/features/dashboard/ui/dashboard.dart';
import 'package:market_student/features/dashboard/ui/my_product_screen.dart';
import 'package:market_student/features/favarite/ui/favarite.dart';
import 'package:market_student/features/forget%20password/ui/forget_password.dart';
import 'package:market_student/features/forget%20password/ui/otp.dart';
import 'package:market_student/features/forget%20password/ui/reset_password.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:market_student/features/home/ui/widgets/main_nav.dart';
import 'package:market_student/features/login/ui/login_screen.dart';
import 'package:market_student/features/login/ui/signup.dart';
import 'package:market_student/features/notification/ui/notification_screen.dart';
import 'package:market_student/features/product/ui/product_details.dart';
import 'package:market_student/features/profile/ui/change_password.dart';
import 'package:market_student/features/profile/ui/help_center.dart';
import 'package:market_student/features/profile/ui/profile_screen.dart';
import 'package:market_student/features/search/ui/search_screen.dart';
import 'package:market_student/features/splash/ui/SplashScreen.dart';
import 'package:market_student/features/on_boarding/ui/on_boarding.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
     GoRoute(
      path: '/splash',
      builder: (context, state) =>  SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) =>  OnBoardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
      GoRoute(
      path: '/signup',
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(path: '/forgot_password',
    builder: (context, state) => ForgotPasswordScreen(),

    ),
    GoRoute(path: '/otp',
    builder: (context, state) =>  VerificationCodeScreen(), ),

    GoRoute(path: '/reset_password',
    builder: (context, state) => ResetPasswordScreen(), ),
  ShellRoute(
    builder: (context, state, child) {
      return MainNavigation(child: child); 
    },
  routes: [
     
   
    GoRoute(
    path: '/home',
   builder: (context, state) => const HomeScreen(),
),
  GoRoute(path: '/product_details',
  builder: (context, state) => ProductDetails(),)
    // Assuming OTP screen is similar
    ,
    GoRoute(path: '/notifications',
    builder: (context, state) => NotificationScreen(),),

    GoRoute(path: '/favarite',
    builder: (context, state) => Favarite(),),

    GoRoute(path: '/search_screen',
    builder: (context, state) => SearchScreen(),),

    GoRoute(path: '/dashboard',
    builder: (context, state) => DashboardScreen(),),

    GoRoute(path:'/my_product_screen',
    builder: (context, state) => MyProductScreen(),),

    GoRoute(path: '/add_product',
    builder: (context, state) => UploadProductScreen(),),

    GoRoute(path: '/chats',
    builder: (context, state) => Chats(),),

    GoRoute(path:'/profile_screen',
    builder: (context, state) => ProfileScreen()),

    GoRoute(path: '/change_password',
    builder: (context, state) => ChangePassword(),),

    GoRoute(path: '/help_center',
    builder: (context, state) => HelpCenter(),)
    ],
  ),
]);
  
