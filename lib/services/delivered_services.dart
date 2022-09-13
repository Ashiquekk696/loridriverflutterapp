import 'dart:convert';
import 'dart:io';

import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:http/http.dart' as http;

class DeliveredServices {
//List<File> images = [];

  Future deliveredService(
      {packageId, driverToken, List<File>? images, amount}) async {
    var uri =
        Uri.parse('https://lori.ae/app/${ApiEndPoints.delivered}$packageId');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      "driver-token": driverToken,
    });
    request.fields['amount'] = amount.toString();
    //print("images are ${images}");
    for (int i = 0; i < images!.length; i++) {
      request.files.add(http.MultipartFile(
          'attachment[$i]',
          File(images[i].path).readAsBytes().asStream(),
          File(images[i].path).lengthSync(),
          filename: images[i].path.split('/').last));
    }

    var streamData = await request.send();
    var response = await http.Response.fromStream(streamData);

    final responseData = json.decode(response.body);
    print("hhkkk${responseData}hhkk");
    return responseData;
  }
}
