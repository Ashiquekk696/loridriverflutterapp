import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class FaqService {
  Future faqService() async {
    var response = await ApiHelper().get("faq", headers: {});
    return response;
  }
}
