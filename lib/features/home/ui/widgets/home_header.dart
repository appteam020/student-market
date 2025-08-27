import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String avatarPath;
  final VoidCallback onNotifications;

  const HomeHeader({super.key, required this.userName, required this.avatarPath, required this.onNotifications});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Consumer<ProfileController>(
        builder: (context, controller, child) {
          return Row(
            children: [
              controller.profileState == RequestState.loading
                  ? CircularProgressIndicator()
                  : CircleAvatar(radius: 24.r, backgroundImage: NetworkImage(controller.profile?.profileImage ?? '')),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.profileState == RequestState.loading
                        ? Text('Loading...')
                        : Text(
                            '${'hello_name'.tr(args: [userName])} ${controller.profile?.fullName ?? ""}',
                            style: Theme.of(context).textTheme.headlineSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                    SizedBox(height: 2.h),
                    Text(
                      'استكشف أحدث المنتجات حولك',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onNotifications,
                icon: SvgPicture.asset('assets/images/notification.svg', width: 24.w, height: 24.h),
              ),
            ],
          );
        },
      ),
    );
  }
}
