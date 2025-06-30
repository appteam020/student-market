import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:market_student/CounterProvider.dart.dart';
import 'package:provider/provider.dart';

import 'cc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/localization',
      fallbackLocale: Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          // أضف المزيد حسب حاجتك
        ],
        child: MyApp(),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome'.tr(),
       locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: NameScreen(),
    );
  }
}

class NameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('الشاشة الأولى'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(
              builder: (context, provider, child) => Text(
                'الاسم الحالي: ${provider.getName}',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                provider.setName("هناء"); // تغيير الاسم
              },
              child: Text('تغيير الاسم إلى "هناء"'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SecondScreen()),
                );
              },
              child: Text('انتقال إلى الشاشة الثانية'),
            ),
          ],
        ),
      ),
    );
  }
}

