
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class RecentTransaction extends StatelessWidget {
  final String photo;
  final String title;
  final String date;
  final String price;
  final String state;
  final String color_state ;


  const RecentTransaction({
    super.key,
    required this.photo,
    required this.title,
    required this.date,
   required this.price,
    required this.state,
    required this.color_state,
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
                        color: colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                ),

             

           SizedBox(height: 24.h,),
             Container(
  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h), 
  decoration: BoxDecoration(
    color: color_state == 'Completed' ? colors.Completed : colors.notCompleted,
    borderRadius: BorderRadius.circular(8),
  ),
  alignment: Alignment.center, 
  child: Text(
    state,
    textAlign: TextAlign.center, 
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colors.textPrimary,
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
