import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../api_Model/app_exception.dart';

class DioServices {
  final dio = Dio();
  var response;

  Future getResponse({
    required String url,
    FormData? body,
  }) async {
    Map<String, dynamic> header = {"Content-Type": "application/json"};
    try {
      ///Dio
      final result =
          await dio.post(url, data: body, options: Options(headers: header));
      response = returnResponse(result.statusCode!, result.data);
    } on SocketException {
      throw FetchDataException('No Internet access');
    }
    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      case 204:
        return {
          "status": "SUCCESS",
          "message": "SuccessFully Query List Get",
          "data": []
        };
      case 400:
        return jsonDecode(result);
      // throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
