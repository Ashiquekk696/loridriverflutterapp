import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class OrdersService {
  Future ordersService({driverToken}) async {
    var response = await ApiHelper().get(ApiEndPoints.orders, headers: {
      "driver-token": driverToken,
    });
    return response;
  }
}
