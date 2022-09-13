import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  preferrnces({token, driverName, bool? isLoggedIn}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setString("driverName", driverName);
    preferences.setBool("isLoggedIn", isLoggedIn ?? false);
  }
}
