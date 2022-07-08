import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class ForgotPasswordService {
  Future forgotPasswordService({email}) async {
    var response = await ApiHelper().post(ApiEndPoints.forgotPassword, body: {
      "email": email,
    });
    print(response);
    return response;
  }
}
