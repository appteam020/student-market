import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/profile/ui/widgets/lang_dialog.dart';
import 'package:market_student/features/profile/ui/widgets/logout.dart';
import 'package:market_student/features/profile/ui/widgets/profile_header.dart';
import 'package:market_student/features/profile/ui/widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
       Scaffold(
        backgroundColor: colors.cards,
        appBar: CustomAppBar(title: tr('nav_profile'), onBack: () => Navigator.pop(context)),
        body: Padding(

          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileHeader(
                  imageUrl: "https://i.pravatar.cc/150?img=1",
                  name: "John Doe",
                  email: "nada@gmail.com",
                  onEdit: () => {},
                
                  ),
                  SizedBox(height: 16.h,),
               Divider(),
              
              SwitchListTile(
                value: true,
                
                onChanged: (val) {},
                title:  Text(
                  tr('notifications')),
                secondary: SvgPicture.asset(
                  'assets/images/notification3.svg'
                 ),
              ),
              Divider(thickness: .5,
              height: 0.5,),
              ProfileOptionTile(
                icon: 'assets/images/language.svg',
                title: tr('change language'),
                onTap: () {
                  showDialog(context: context,
                   builder: (BuildContext context){
                    return LanguageDialog();
                   });
                },
              ),
              Divider(thickness: .5,
              height: .5,),
              ProfileOptionTile(
                icon: 'assets/images/love.svg',
                title: tr('Favorites'),
                onTap: () {},
              ),
              Divider(thickness: .5,
              height: .5,),
              ProfileOptionTile(
                icon: 'assets/images/security.svg',
                title: tr('change_pass'),
                onTap: () {
                  context.push('/change_password');
                },
              ),
              Divider(thickness: .5,
              height: .5,),
              ProfileOptionTile(
                icon: 'assets/images/help.svg',
                title: tr('Help_Center'),
                onTap: () {
                  context.push('/help_center');
                },
              ),
              Divider(thickness: .5,
              height: .5,),
              ProfileOptionTile(
                icon: 'assets/images/logout.svg',
                title: tr('logout'),
                iconColor: Colors.red,
                onTap: () {
                  showDialog(
                    
                  context: context,
                  builder: (BuildContext context) {
                    return  LogoutDialog();
                  },
              ) ; },
              ),
            ],
                    ),
          ),
      ),
    ));
  }
}

