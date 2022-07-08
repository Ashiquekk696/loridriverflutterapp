import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class LoginService {
  Future loginService({email, password}) async {
    var response = await ApiHelper().post(ApiEndPoints.login, body: {
      "email": email,
      "password": password,
    });

    return response;
  }
}
