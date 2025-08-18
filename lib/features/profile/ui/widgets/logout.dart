// logout_dialog.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      backgroundColor: colors.cards,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding:  EdgeInsets.all(24.0),
        child: Container(
          width: 300.w,
          child: Column(
            
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
               tr('logout_dialog_title'),
                textAlign: TextAlign.center,
                style:Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
               SizedBox(height: 8),
               Text(
                tr('logout_dialog_message'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary
                )
              ),
               SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // تأكيد تسجيل الخروج
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:colors.notCompleted,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(tr('Logout'), 
                      style: TextStyle(fontSize: 16,color: colors.cards)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // إلغاء
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color:colors.notCompleted),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                       tr('cancel'),
                        style: TextStyle(fontSize: 16, color:colors.notCompleted),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}