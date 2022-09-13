import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/notifications_model.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';
import 'package:loridriverflutterapp/services/notifications_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsBloc {
  final notificationsController =
      StreamController<ApiResponse<NotificationsModel>>();
  StreamSink<ApiResponse<NotificationsModel>> get notifactionsSink =>
      notificationsController.sink;

  Stream<ApiResponse<NotificationsModel>> get notificationsStream =>
      notificationsController.stream;
  dispose() {
    notificationsController.close();
  }

  getNotificationsData() async {
    notifactionsSink.add(ApiResponse.loading("LOADING..."));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var driverToken = await preferences.getString("token");
    print("ddd${driverToken}");
    var response = await NotificationService()
        .notificationService(driverToken: driverToken);
    print(response);

    if (response["error"] == false) {
      notifactionsSink
          .add(ApiResponse.completed(NotificationsModel.fromJson(response)));
    } else
      notifactionsSink.add(ApiResponse.error(response["msg"]));
  }
}
