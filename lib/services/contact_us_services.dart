import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class ContactUsService {
  Future contactUsService({email, phone, name, description}) async {
    var response = await ApiHelper().post(ApiEndPoints.contactUs, body: {
      "email": email,
      "phone": phone,
      "name": name,
      "description": description,
    });

    return response;
  }
}
