import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/features/dashboard/ui/widgets/empty_product.dart';
import 'package:market_student/features/dashboard/ui/widgets/header.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DashboardHeader(title: tr('My_Products')),
      
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               EmptyProduct(),
              
              ],
              
            ),
          ),
        
        ),
      ),
    );
    
  }
}