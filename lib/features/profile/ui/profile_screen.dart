import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:market_student/core/di/get_it.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/login/ui/widgets/custom_text_field.dart';
import 'package:market_student/features/profile/controller/noti_controller.dart';
import 'package:market_student/features/profile/controller/profile_controller.dart';
import 'package:market_student/features/profile/ui/widgets/lang_dialog.dart';
import 'package:market_student/features/profile/ui/widgets/logout.dart';
import 'package:market_student/features/profile/ui/widgets/profile_header.dart';
import 'package:market_student/features/profile/ui/widgets/profile_tile.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import '../../login/ui/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.cards,

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChangeNotifierProvider.value(
                  value: getIt<ProfileController>(),
                  child: Consumer<ProfileController>(
                    builder: (context, controller, child) {
                      switch (controller.profileState) {
                        case RequestState.loading:
                          return const Center(child: CircularProgressIndicator());
                        case RequestState.success:
                          return ProfileHeader(
                            imageUrl: controller.profile?.profileImage ?? "",
                            name: controller.profile?.fullName ?? "",
                            email: controller.profile?.email ?? "",

                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChangeNotifierProvider.value(
                                    value: getIt<ProfileController>()..initialValue(controller.profile?.fullName ?? ""),
                                    child: Consumer<ProfileController>(
                                      builder: (context, provider, child) {
                                        return AlertDialog(
                                          title: Text(tr('edit_profile_name')),
                                          content: Form(
                                            key: provider.formkey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomTextField(
                                                  label: tr("name"),
                                                  hint: tr("enter your name"),
                                                  controller: controller.nameController,
                                                  keyboardType: TextInputType.name,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return tr('name_is_required');
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: provider.editProfileName == RequestState.loading
                                                  ? CircularProgressIndicator()
                                                  : Text(tr('save')),
                                              onPressed: () {
                                                provider.updateProfileName(context);
                                              },
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Text(tr('cancel')),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        case RequestState.error:
                          return Column(
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              Text(controller.errorMessage),
                              TextButton(
                                onPressed: () {
                                  controller.getProfile();
                                },
                                child: Text('try again'),
                              ),
                            ],
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Divider(),

                ChangeNotifierProvider(
                  create: (context) => NotiController()..initStatus(),
                  child: Consumer<NotiController>(
                    builder: (context, value, child) {
                      return SwitchListTile(
                        value: value.isNotificationsEnabled,

                        onChanged: (val) async {
                          value.toggleNotifications(val);
                        },
                        title: Text(tr('notifications')),
                        secondary: SvgPicture.asset('assets/images/notification3.svg'),
                      );
                    },
                  ),
                ),
                Divider(thickness: .5, height: 0.5),
                ProfileOptionTile(
                  icon: 'assets/images/language.svg',
                  title: tr('change language'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LanguageDialog();
                      },
                    );
                  },
                ),
                Divider(thickness: .5, height: .5),
                ProfileOptionTile(
                  icon: 'assets/images/love.svg',
                  title: tr('Favorites'),
                  onTap: () {
                    context.push('/favorites');
                  },
                ),
                Divider(thickness: .5, height: .5),
                ProfileOptionTile(
                  icon: 'assets/images/security.svg',
                  title: tr('change_pass'),
                  onTap: () {
                    context.push('/change_password');
                  },
                ),
                Divider(thickness: .5, height: .5),
                ProfileOptionTile(
                  icon: 'assets/images/help.svg',
                  title: tr('Help_Center'),
                  onTap: () {
                    context.push('/help_center');
                  },
                ),
                Divider(thickness: .5, height: .5),
                ProfileOptionTile(
                  icon: 'assets/images/logout.svg',
                  title: tr('logout'),
                  iconColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LogoutDialog();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
