import 'package:intl/date_symbol_data_local.dart';
import 'all_file.dart';
import 'package:get/get.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  initializeDateFormatting().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      locale: Locale('vi', 'VN'),
      title: 'DotB Final Test',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.transparent,
        fontFamily: 'Quicksand',
        primaryIconTheme: IconThemeData(color: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
