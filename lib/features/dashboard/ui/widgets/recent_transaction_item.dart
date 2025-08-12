
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class RecentTransaction extends StatelessWidget {
  final String photo;
  final String title;
  final String date;
  final String price;
  final String state;


  const RecentTransaction({
    super.key,
    required this.photo,
    required this.title,
    required this.date,
   required this.price,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color:const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.r),
        
        boxShadow: [
          BoxShadow(
            color: colors.textSecondary.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Image.asset(
            photo,
            width: 85.w,
            height: 85.h,
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                ), SizedBox(height: 24.h,),
                
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                ),
              ],
            ),
          ),

         
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            
            children: [
Text(
 price,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                ),

             

           SizedBox(height: 24.h,),
             Container(
  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h), 
  decoration: BoxDecoration(
    color: colors.secondary.withOpacity(.3),
    borderRadius: BorderRadius.circular(8),
  ),
  alignment: Alignment.center, 
  child: Text(
    state,
    textAlign: TextAlign.center, 
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colors.secondary,
          fontWeight: FontWeight.bold,
        ),
  ),
)
              
            ],
           
         )
        ],
      ),
    );
  }
}
