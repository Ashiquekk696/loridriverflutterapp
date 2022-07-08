import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  preferrnces({token, driverName}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setString("driverName", driverName);
  }
}
