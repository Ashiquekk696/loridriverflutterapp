import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiHelper {
  String baseUrl = "https://lori.ae/app/";

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    var responseJson;
    var api = baseUrl + url;
    try {
      var response = await http.get(Uri.parse(api), headers: headers);
      print(api);
      responseJson = getResponse(response);
    } on SocketException {
      throw FetchDataException("Something error");
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, String>? headers, dynamic body}) async {
    var responseJson;
    try {
      var response = await http.post(Uri.parse(baseUrl + url),
          body: body, headers: headers);

      responseJson = await getResponse(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("Something error");
    }
  }

  Future<dynamic> delete(String url,
      {Map<String, String>? headers, dynamic body}) async {
    var responseJson;
    try {
      var response = await http.delete(Uri.parse(baseUrl + url),
          body: body, headers: headers);

      responseJson = await getResponse(response);

      return responseJson;
    } on SocketException {
      throw FetchDataException("Something error");
    }
  }
}

Future<dynamic> getResponse(http.Response response) async {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(utf8.decode(response.bodyBytes));

      return responseJson;

    case 201:
      var responseJson = json.decode(utf8.decode(response.bodyBytes));

      return responseJson;

    default:
      var responseJson = json.decode(utf8.decode(response.bodyBytes));

      return responseJson;
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);
}

class FetchDataException extends AppException {
  FetchDataException([String message = "hh"]) : super(message, "Error");
}

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data, {this.message}) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
