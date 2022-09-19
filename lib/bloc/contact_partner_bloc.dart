import 'dart:async';

import 'package:loridriverflutterapp/models/contact_partner_model.dart';
import 'package:loridriverflutterapp/services/contact_partner_services.dart';

import '../helpers/api_helper.dart';

class ContactPartnerBloc {
  final contactController =
      StreamController<ApiResponse<ContactPartnerModel>>();
  StreamSink<ApiResponse<ContactPartnerModel>> get contactPartnerSink =>
      contactController.sink;

  Stream<ApiResponse<ContactPartnerModel>> get contactsPartnerStream =>
      contactController.stream;
  dispose() {
    contactController.close();
  }

  getPartnerData() async {
    contactPartnerSink.add(ApiResponse.loading("LOADING..."));

    var response = await ContactPartnerService().contactPartnerService();

    if (response["error"] == false) {
      contactPartnerSink
          .add(ApiResponse.completed(ContactPartnerModel.fromJson(response)));
    } else
      contactPartnerSink.add(ApiResponse.error(response["msg"]));
  }
}
