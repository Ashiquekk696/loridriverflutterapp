import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class CollectedCashServices {
  Future collectedCashServices({driverToken}) async {
    var response = await ApiHelper().get(ApiEndPoints.collectedCash, headers: {
      "driver-token": driverToken,
    });
    return response;
  }
}
