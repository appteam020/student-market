import 'package:get_it/get_it.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/features/dashboard/controller/dashboard_controller.dart';
import 'package:market_student/features/favorites_page/controller/favorites_provider.dart';
import 'package:market_student/features/home/controller/main_controller.dart';
import 'package:market_student/features/login/controller/login_controller.dart';
import 'package:market_student/features/login/controller/signup_controller.dart';
import 'package:market_student/features/notification/controller/notifications_procider.dart';
import 'package:market_student/features/product/controller/product_details_controller.dart';
import 'package:market_student/features/profile/controller/profile_controller.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<FavoritesController>(() => FavoritesController());
  getIt.registerLazySingleton<MainProvider>(() => MainProvider());
  getIt.registerLazySingleton<DashboardController>(() => DashboardController());
  getIt.registerLazySingleton<ProductDetailsController>(() => ProductDetailsController());
  getIt.registerLazySingleton<LoginProvider>(() => LoginProvider());
  getIt.registerLazySingleton<SignUpProvider>(() => SignUpProvider());
  getIt.registerLazySingleton<ProfileController>(() => ProfileController());
  getIt.registerLazySingleton<FavoritesProvider>(() => FavoritesProvider());
  getIt.registerLazySingleton<NotificationsProvider>(() => NotificationsProvider());
}
