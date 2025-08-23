import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_student/core/eunm/request_state.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/features/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;

  final String name;
  final String email;
  final Function()? onEdit;

  final ProfileController controller;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.onEdit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 60.r,
              backgroundImage: NetworkImage(
                imageUrl == '' ? 'https://icons.veryicon.com/png/o/miscellaneous/user-avatar/user-avatar-male-5.png' : imageUrl,
              ),
              backgroundColor: colors.primary,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ChangeNotifierProvider.value(
                        value: controller,
                        child: Consumer<ProfileController>(
                          builder: (context, controller, child) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('تعديل الصورة الشخصية'),
                                  SizedBox(height: 16.h),
                                  CircleAvatar(
                                    radius: 60.r,
                                    backgroundImage: controller.file != null
                                        ? FileImage(controller.file!)
                                        : NetworkImage(
                                            imageUrl == ''
                                                ? 'https://icons.veryicon.com/png/o/miscellaneous/user-avatar/user-avatar-male-5.png'
                                                : imageUrl,
                                          ),
                                    backgroundColor: colors.primary,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.pickImage(ImageSource.gallery);
                                        },
                                        icon: Icon(Icons.image),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.pickImage(ImageSource.camera);
                                        },
                                        icon: Icon(Icons.camera_alt_outlined),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  controller.file != null
                                      ? controller.stateUploadImage == RequestState.loading
                                            ? const Center(child: CircularProgressIndicator())
                                            : ElevatedButton(
                                                onPressed: () {
                                                  controller.updateProfileImage(context);
                                                },
                                                child: Text('تعديل الصورة الشخصية'),
                                              )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.camera_alt_outlined, color: colors.secondary),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(name, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8.h),
        Text(email, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: colors.primary, // اللون الأخضر
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.transparent, // بدون خلفية
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // يخلي حجم الزر وسط قد المحتوى
              children: [
                SvgPicture.asset('assets/images/edit.svg', width: 20.w, height: 20.h, color: colors.primary),
                SizedBox(width: 8.w),
                Text("تعديل الملف الشخصي", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.primary)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
