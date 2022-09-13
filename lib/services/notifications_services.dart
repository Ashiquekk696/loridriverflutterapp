import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class NotificationService {
  Future notificationService({driverToken}) async {
    var response = await ApiHelper().get(ApiEndPoints.notifications, headers: {
      "driver-token": driverToken,
    });

    print("my token is $driverToken");
    return response;
  }
}
