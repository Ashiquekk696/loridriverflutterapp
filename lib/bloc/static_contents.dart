import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';
import 'package:loridriverflutterapp/services/notifications_services.dart';
import 'package:loridriverflutterapp/services/static_contents_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/orders_services.dart';

class StaticContentsBloc {
  final privacyPolicyController = StreamController<ApiResponse<String>>();
  StreamSink<ApiResponse<String>> get staticContentsSink =>
      privacyPolicyController.sink;

  Stream<ApiResponse<String>> get staticContentsStream =>
      privacyPolicyController.stream;
  dispose() {
    privacyPolicyController.close();
  }

  privacyPolicyData({type}) async {
    staticContentsSink.add(ApiResponse.loading("LOADING..."));

    var response =
        await StaticContentsServices().staticContentsServices(type: type);

    if (response != null) {
      staticContentsSink.add(ApiResponse.completed(response));
    } else
      staticContentsSink.add(ApiResponse.error(response["msg"]));
  }
}
