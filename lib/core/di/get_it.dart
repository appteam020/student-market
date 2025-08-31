import 'package:get_it/get_it.dart';
import 'package:market_student/core/favorites_controller.dart';
import 'package:market_student/features/home/controller/main_controller.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<FavoritesController>(() => FavoritesController());
  getIt.registerLazySingleton<MainProvider>(() => MainProvider());
}
