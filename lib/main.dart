import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:market_student/core/routing/app_routing.dart';
import 'package:market_student/features/home/controller/main_controller.dart';
import 'package:market_student/features/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vhemxggjxvdpyfcuirsv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZoZW14Z2dqeHZkcHlmY3VpcnN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU2MDA5MDksImV4cCI6MjA3MTE3NjkwOX0.ENziPYM3KSyTTpyVKVyQEOEQUpP73pUYMb9V_L6-tTQ',
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/localization',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MainProvider())],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: LightAppTheme.themeData,
          darkTheme: DarkAppTheme.themeData,
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
