import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class LogOutService {
  Future logOutService({userToken}) async {
    var response = await ApiHelper()
        .post(ApiEndPoints.logOut, headers: {"driver-token": userToken});
    print(response);
    return response;
  }
}
