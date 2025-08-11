import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/dashboard/ui/widgets/header.dart';
import 'package:market_student/features/dashboard/ui/widgets/item_dashboard.dart';

class DashboardScreen0 extends StatelessWidget {
  const DashboardScreen0({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DashboardHeader(),
        body: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            children:[
              Row(
                children: [
                   ItemDashboard(
                    svgIcon: 'assets/images/profit.svg',
                    title: "الأرباح الإجمالية",
                    count: "1258 شيكل",
                    backgroundColor: colors.secondary.withOpacity(0.1),
                  ),
                  
                   ItemDashboard(
                    svgIcon: 'assets/images/profit.svg',
                    title: "الأرباح الإجمالية",
                    count: "1258 شيكل",
                    backgroundColor: colors.secondary.withOpacity(0.1),
                  ),
                 
                ],
              )
            ]






         

       
          ),
        ),
      ),
    );
  }
}
