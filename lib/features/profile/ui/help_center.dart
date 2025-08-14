import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_student/core/theme/colors.dart';
import 'package:market_student/core/widget/app_bar.dart';
import 'package:market_student/features/add%20product/ui/widgets/inpu_filed.dart';
import 'package:market_student/features/login/ui/widgets/custom_button.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.cards,
      appBar: CustomAppBar(title: "Help Center",),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Do you have a question or issue?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.textPrimary
                ),
              ),
              SizedBox(height: 8.h,),
                  Text(
                "Write your question, and we will respond to you via email or in the messages section.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary
                ),
              ),
           
                CustomTextField(
                label:"",
                hint: "Write your question or inquiry here...",
                type: 'description',
                controller: TextEditingController(),
                  
              ),
              SizedBox(height: 16.h,),
              CustomButton(text: "Send question", onPressed:(){})
          
            ],
                ),
        )),

    );
  }
}