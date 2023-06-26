import 'package:get/get.dart';
import '../all_file.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _onLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Color(0xFFEDF3FF),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Center(
              child: ClipOval(
                child: Container(
                  width: Get.width,
                  height: Get.width,
                  color: Color(0xFFE5EEFF),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SvgPicture.asset(
                'assets/svg/splash_bg.svg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: ClipOval(
                child: Container(
                  width: Get.width / 2,
                  height: Get.width / 2,
                  color: Color(0xFFDBE7FF),
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/img/splash_logo.png',
                          width: Get.width / 5,
                          height: Get.width / 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _onLoading() async {
    prefsController.updatePrefs();
    await Future.delayed(Duration(seconds: 2));
    Get.offNamed(Routes.HOME);
  }
}
