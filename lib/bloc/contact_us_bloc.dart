// import 'dart:async';

// import 'package:loridriverflutterapp/helpers/api_helper.dart';
// import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
// import 'package:loridriverflutterapp/services/contact_us_services.dart';
// import 'package:loridriverflutterapp/services/login_services.dart';

// class ContactUsBloc {
//   final contactUsBlocController = StreamController<ApiResponse<bool>>();
//   StreamSink<ApiResponse<bool>> get contactUsSink =>
//       contactUsBlocController.sink;

//   Stream<ApiResponse<bool>> get contactUsStream =>
//       contactUsBlocController.stream;
//   dispose() {
//     contactUsBlocController.close();
//   }

//   contactUs({email, phone, description, name}) async {
//     contactUsSink.add(ApiResponse.loading("LOADING..."));

//     var response = await ContactUsService().contactUsService(
//         email: email, phone: phone, description: description, name: name);

//     if (response["error"] == false) {
//       print(response['msg']);
//       contactUsSink.add(ApiResponse.completed(true));
//     } else
//       contactUsSink.add(ApiResponse.error(response["msg"]));
//   }
// }
