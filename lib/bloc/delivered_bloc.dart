import 'dart:async';
import 'dart:io';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/services/delivered_services.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/picked_up_services.dart';
import 'package:loridriverflutterapp/services/shop_order_deliverd_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveredBloc {
  final deliveredController = StreamController<ApiResponse<bool>>();
  StreamSink<ApiResponse<bool>> get deliveredSink => deliveredController.sink;

  Stream<ApiResponse<bool>> get deliveredStream => deliveredController.stream;
  dispose() {
    deliveredController.close();
  }

  delivered({List<File>? images, packageId, amount}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");
    deliveredSink.add(ApiResponse.loading("LOADING..."));

    var response = await DeliveredServices().deliveredService(
        driverToken: driverToken,
        images: images,
        packageId: packageId,
        amount: amount);

    if (response["error"] == false) {
      deliveredSink.add(ApiResponse.completed(true));
    } else
      deliveredSink.add(ApiResponse.error(response["msg"]));
  }

  shopOrdersdelivered({List<File>? images, packageId, amount}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");
    deliveredSink.add(ApiResponse.loading("LOADING..."));

    var response = await ShopOrderDeliveredServices()
        .shopOrderDeliveredUServices(
            driverToken: driverToken,
            images: images,
            packageId: packageId,
            amount: amount);

    if (response["error"] == false) {
      deliveredSink.add(ApiResponse.completed(true));
    } else
      deliveredSink.add(ApiResponse.error(response["msg"]));
  }
}
