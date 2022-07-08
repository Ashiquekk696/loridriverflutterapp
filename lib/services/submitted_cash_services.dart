import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class SubmittedCashServices {
  Future submittedCashServices({driverToken}) async {
    var response = await ApiHelper().get(ApiEndPoints.submittedCash, headers: {
      "driver-token": driverToken,
    });
    return response;
  }
}
