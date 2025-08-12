
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/theme/colors.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DashboardHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:colors.cards,
      elevation: .5,
      centerTitle: true,
     shadowColor:colors.textSecondary.withOpacity(0.3),
      toolbarHeight: 80.h,
      title: Text(
        title,
       
        style: TextStyle(color:colors.textPrimary),
      ),
      leading:IconButton(onPressed: (){},
       icon: SvgPicture.asset(
    'assets/images/notification.svg',
        width: 24.w,
       height: 24.w,
 
   
  ) )
       ,

      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/user.png"),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
