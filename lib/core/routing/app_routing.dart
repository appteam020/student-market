
    import 'package:go_router/go_router.dart';
import 'package:market_student/feautres/splash/ui/splash_screen.dart';

    final GoRouter router =GoRouter(
      routes: [
      GoRoute(path: "/",
      builder:(context, state) => splash_screen(),
      )
      ]
      );