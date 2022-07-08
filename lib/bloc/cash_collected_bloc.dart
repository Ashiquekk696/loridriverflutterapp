import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/cash_collected_model.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/services/collected_cash_services.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';
import 'package:loridriverflutterapp/services/notifications_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/orders_services.dart';

class CollectedCashBloc {
  final cashCollectedController =
      StreamController<ApiResponse<CashCollectedModel>>();
  StreamSink<ApiResponse<CashCollectedModel>> get cashCollectedSink =>
      cashCollectedController.sink;

  Stream<ApiResponse<CashCollectedModel>> get cashCollectedStream =>
      cashCollectedController.stream;
  dispose() {
    cashCollectedController.close();
  }

  getCollectedCashData() async {
    cashCollectedSink.add(ApiResponse.loading("LOADING..."));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");

    var response = await CollectedCashServices()
        .collectedCashServices(driverToken: driverToken);
    print(response);
    if (response["error"] == false) {
      cashCollectedSink
          .add(ApiResponse.completed(CashCollectedModel.fromJson(response)));
    } else
      cashCollectedSink.add(ApiResponse.error(response["msg"]));
  }
}
