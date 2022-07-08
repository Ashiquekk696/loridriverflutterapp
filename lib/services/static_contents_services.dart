import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:loridriverflutterapp/helpers/api_helper.dart';

class StaticContentsServices {
  Future staticContentsServices({type}) async {
    var url = "https://lori.ae/app/$type";
    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
