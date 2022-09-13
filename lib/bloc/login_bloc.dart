import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/services/login_services.dart';

class LoginBloc {
  final loginController = StreamController<ApiResponse<bool>>();
  StreamSink<ApiResponse<bool>> get loginSink => loginController.sink;

  Stream<ApiResponse<bool>> get loginStream => loginController.stream;
  dispose() {
    loginController.close();
  }

  login({email, password}) async {
    loginSink.add(ApiResponse.loading("LOADING..."));

    var response =
        await LoginService().loginService(email: email, password: password);

    if (response["error"] == false) {
      loginSink.add(ApiResponse.completed(true));
      Preferences().preferrnces(
          isLoggedIn: true,
          token: response["api_token"],
          driverName: response['driver_details']['name']);
    } else
      loginSink.add(ApiResponse.error(response["msg"]));
  }
}
