import 'package:get/get.dart';
import 'package:interview/ui/CreateTask.dart';
import 'package:interview/ui/homeMain.dart';
import '../all_file.dart';

part './app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.HOMEMAIN,
      page: () => HomeMain(),
    ),
    GetPage(
      name: Routes.CREATETASK,
      page: () => CreateTask(),
    ),
  ];
}
