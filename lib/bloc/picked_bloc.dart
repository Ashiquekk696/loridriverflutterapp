import 'dart:async';
import 'dart:io';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/picked_up_services.dart';
import 'package:loridriverflutterapp/services/shop_order_pickedup_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickedUpBloc {
  final pickedUpController = StreamController<ApiResponse<bool>>();
  StreamSink<ApiResponse<bool>> get pickedUpSink => pickedUpController.sink;

  Stream<ApiResponse<bool>> get pickedUpStream => pickedUpController.stream;
  dispose() {
    pickedUpController.close();
  }

  pickedUp({List<File>? images, packageId, amount}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");
    pickedUpSink.add(ApiResponse.loading("LOADING..."));

    var response = await PickedUpService().pickedUpService(
        driverToken: driverToken,
        images: images,
        packageId: packageId,
        amount: amount);

    if (response["error"] == false) {
      pickedUpSink.add(ApiResponse.completed(true));
    } else
      pickedUpSink.add(ApiResponse.error(response["msg"]));
  }

  shopOrdersPickedUp({List<File>? images, packageId, amount}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");
    pickedUpSink.add(ApiResponse.loading("LOADING..."));

    var response = await ShopOrderPickedUServices().shopOrderPickedUServices(
        driverToken: driverToken,
        images: images,
        packageId: packageId,
        amount: amount);

    if (response["error"] == false) {
      pickedUpSink.add(ApiResponse.completed(true));
    } else
      pickedUpSink.add(ApiResponse.error(response["msg"]));
  }
}
