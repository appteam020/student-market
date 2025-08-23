import 'package:flutter/material.dart';
import 'package:market_student/features/home/ui/home.dart';
import 'package:market_student/features/home/ui/widgets/main_nav.dart';
import 'package:market_student/features/login/ui/login_screen.dart';
import 'package:market_student/features/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ProfileController()..getProfile())],
      child: StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          print(snapshot.error);
          print(snapshot.connectionState);
          print(snapshot.data?.session);

          if (snapshot.hasError) {
            return const LoginScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.session == null) {
            return const LoginScreen();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const LoginScreen();
          } else {
            return MainNavigation(child: const HomeScreen());
          }
        },
      ),
    );
  }
}
