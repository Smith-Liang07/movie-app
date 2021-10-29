import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sobatbisnis_assesment/exception/app_exception.dart';

class ApiBaseHelper {
  final http.Client httpClient;
  String _baseUrl = "http://api.themoviedb.org/3/";

  ApiBaseHelper({required this.httpClient});

  Future<dynamic> get(String url) async {
    try {
      var resp = await httpClient.get(Uri.parse(_baseUrl + url));
      return _getResponse(resp);
    } on SocketException {
      print("no internet");
      throw BadConnectionException("No internet connection");
    }
  }

  _getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadConnectionException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw BadConnectionException(response.body.toString());
    }
  }
}
