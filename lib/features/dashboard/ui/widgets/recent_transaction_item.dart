
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentTransactionItem extends StatelessWidget {
  final String title;
  final String price;
  final String status;
  final String date ; 
  final String imageUrl;


  const RecentTransactionItem({
    super.key,
    required this.title,
    required this.price,
    required this.status,
    required this.imageUrl, 
    required this.date,

  });

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Image.asset(imageUrl, width: 48.w, height: 48.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 4.h),
                  Text(date, style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
   Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Text(price, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 4.h),
                  Text(status, style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
