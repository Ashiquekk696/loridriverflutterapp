import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/services/forgot_password_services.dart';
import 'package:loridriverflutterapp/services/login_services.dart';

class ForgotPasswordBloc {
  final forgotPasswordController = StreamController<ApiResponse<bool>>();
  StreamSink<ApiResponse<bool>> get forgotPasswordSink =>
      forgotPasswordController.sink;

  Stream<ApiResponse<bool>> get forgotPasswordStream =>
      forgotPasswordController.stream;
  dispose() {
    forgotPasswordController.close();
  }

  forgptPassword({
    email,
  }) async {
    forgotPasswordSink.add(ApiResponse.loading("LOADING..."));

    var response =
        await ForgotPasswordService().forgotPasswordService(email: email);

    if (response["error"] == false) {
      forgotPasswordSink.add(ApiResponse.completed(true));
    } else
      forgotPasswordSink.add(ApiResponse.error(response["msg"]));
  }
}
