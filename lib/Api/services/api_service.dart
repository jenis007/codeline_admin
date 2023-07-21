import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../api_Model/app_exception.dart';

enum APIType { aGet, aPost, aPut, aDelete }

class APIService {
  var response;

  Future getResponse({
    required String url,
    required APIType apiType,
    Map<String, dynamic>? body,
  }) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      ///GetApi---------------------------------
      if (apiType == APIType.aGet) {
        final result = await http.get(Uri.parse(url));
        response = returnResponse(result.statusCode, result.body);
      }

      ///PostApi---------------------------------
      else if (apiType == APIType.aPost) {
        final result = await http.post(Uri.parse(url),
            headers: header, body: jsonEncode(body));

        response = returnResponse(result.statusCode, result.body);
      }

      ///PutApi
      else if (apiType == APIType.aPut) {
        final result = await http.put(Uri.parse(url),
            headers: header, body: jsonEncode(body));
        response = returnResponse(result.statusCode, result.body);
      }
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
