import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/features/forget%20password/ui/forget_password.dart';
import 'package:market_student/features/forget%20password/ui/otp.dart';
import 'package:market_student/features/forget%20password/ui/reset_password.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:market_student/features/login/ui/login_screen.dart';
import 'package:market_student/features/login/ui/signup.dart';
import 'package:market_student/features/product/ui/product_details.dart';
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
    GoRoute(
    path: '/home',
   builder: (context, state) => const HomeScreen(),
),
  GoRoute(path: '/product_details',
  builder: (context, state) => ProductDetails(),)
    // Assuming OTP screen is similar
    
  ],
);
