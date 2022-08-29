import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';
import 'package:loridriverflutterapp/services/notifications_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/orders_services.dart';

class OrderssBloc {
  final ordersController = StreamController<ApiResponse<OrdersModel>>();
  StreamSink<ApiResponse<OrdersModel>> get orderssSink => ordersController.sink;

  Stream<ApiResponse<OrdersModel>> get orderssStream => ordersController.stream;
  dispose() {
    ordersController.close();
  }

  getOrdersData() async {
    orderssSink.add(ApiResponse.loading("LOADING..."));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");

    var response =
        await OrdersService().ordersService(driverToken: driverToken);
    print("ooo${response}");
    if (response["error"] == false) {
      orderssSink.add(ApiResponse.completed(OrdersModel.fromJson(response)));
    } else
      orderssSink.add(ApiResponse.error(response["msg"]));
  }
}
