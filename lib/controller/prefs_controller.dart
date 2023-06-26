import 'package:get/get.dart';
import '../all_file.dart';

abstract class PrefsKey {
  static const PORTAL_NAME = 'portal_name';
  static const PASSWORD = 'password';
  static const TOKEN_EXPIRES = 'expires_in';
  static const USER_MODE = 'user_mode';
}

class PrefsController extends GetxController {
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    updatePrefs();
  }

  updatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs.setString(key, value);
    updatePrefs();
  }

  String getString(String key) {
    if (prefs.containsKey(key)) {
      return prefs.getString(key)!;
    } else {
      return '';
    }
  }

  void removeKey(String key) {
    prefs.remove(key);
    updatePrefs();
  }
}

PrefsController prefsController =
    Get.put<PrefsController>(PrefsController(), permanent: true);
