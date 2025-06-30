
import 'package:flutter/material.dart';
import 'package:market_student/CounterProvider.dart.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الشاشة الثانية'),
      ),
      body: Center(
        child: 
        Consumer<CounterProvider>(
          builder: (context, provider, child) => Text(
            'الاسم هنا أيضًا: ${provider.getName}',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}