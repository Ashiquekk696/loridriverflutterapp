import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';

class LogOutBloc {
  final logoutController = StreamController<ApiResponse<bool>>();
  StreamSink<ApiResponse<bool>> get logOutSink => logoutController.sink;

  Stream<ApiResponse<bool>> get logOutStream => logoutController.stream;
  dispose() {
    logoutController.close();
  }

  logOut({userToken}) async {
    logOutSink.add(ApiResponse.loading("LOADING..."));

    var response = await LogOutService().logOutService(userToken: userToken);
    print(response);
    if (response["error"] == false) {
      logOutSink.add(ApiResponse.completed(true));
    } else
      logOutSink.add(ApiResponse.error(response["msg"]));
  }
}
