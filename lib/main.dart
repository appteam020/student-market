import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/routing/app_routing.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart' as AppTheme;
import 'core/theme/dark_theme.dart' as AppTheme;
import 'core/theme/light_theme.dart';
import 'feautres/splash/ui/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],
      path: 'assets/localization', 
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       
      ],
      child: ScreenUtilInit(
        designSize: const Size(393,852),// المقاس من Figma
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routerConfig: router,
          theme: LightAppTheme.themeData,
          darkTheme:  DarkAppTheme.themeData,
          themeMode: ThemeMode.light, 
           // غيرها حسب شاشتك
        ),
      ),
    );
  }
}
