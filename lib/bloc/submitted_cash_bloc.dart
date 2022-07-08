import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/cash_collected_model.dart';
import 'package:loridriverflutterapp/models/cash_submitted_model.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/services/collected_cash_services.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';
import 'package:loridriverflutterapp/services/notifications_services.dart';
import 'package:loridriverflutterapp/services/submitted_cash_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/orders_services.dart';

class SubmittedCashBloc {
  final submittedCollectedController =
      StreamController<ApiResponse<CashSubmittedModel>>();
  StreamSink<ApiResponse<CashSubmittedModel>> get submittedCollectedSink =>
      submittedCollectedController.sink;

  Stream<ApiResponse<CashSubmittedModel>> get submittedCashStream =>
      submittedCollectedController.stream;
  dispose() {
    submittedCollectedController.close();
  }

  getSubmittedCashData() async {
    submittedCollectedSink.add(ApiResponse.loading("LOADING..."));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = preferences.getString("token");

    var response = await SubmittedCashServices()
        .submittedCashServices(driverToken: driverToken);
    print(response);
    if (response["error"] == false) {
      submittedCollectedSink
          .add(ApiResponse.completed(CashSubmittedModel.fromJson(response)));
    } else
      submittedCollectedSink.add(ApiResponse.error(response["msg"]));
  }
}
