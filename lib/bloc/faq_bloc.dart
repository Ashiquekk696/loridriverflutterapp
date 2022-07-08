import 'dart:async';

import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/faq_model.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/services/faq_services.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/services/logout_services.dart';
import 'package:loridriverflutterapp/services/notifications_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/orders_services.dart';

class FaqBloc {
  final faqController = StreamController<ApiResponse<FaqModel>>();
  StreamSink<ApiResponse<FaqModel>> get faqSink => faqController.sink;

  Stream<ApiResponse<FaqModel>> get faqStream => faqController.stream;
  dispose() {
    faqController.close();
  }

  getFaqData() async {
    faqSink.add(ApiResponse.loading("LOADING..."));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await FaqService().faqService();
    if (response["error"] == false) {
      faqSink.add(ApiResponse.completed(FaqModel.fromJson(response)));
    } else
      faqSink.add(ApiResponse.error(response["msg"]));
  }
}
