import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactPartnerService {
  Future contactPartnerService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = await preferences.getString("token");
    var response = await ApiHelper().get(ApiEndPoints.contactPartner,
        headers: {"driver-token": driverToken ?? ""});

    return response;
  }
}
