import 'dart:convert';
import 'dart:io';

import 'package:loridriverflutterapp/helpers/api_endpoints.dart';
import 'package:loridriverflutterapp/helpers/api_helper.dart';
import 'package:http/http.dart' as http;

class PickedUpService {
//List<File> images = [];

  Future pickedUpService(
      {packageId, driverToken, List<File>? images, amount}) async {
    var uri =
        Uri.parse('https://lori.ae/app/${ApiEndPoints.pickedUp}$packageId');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      "driver-token": driverToken,
    });
    print("my images are $images");
    request.fields['amount'] = amount;
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
