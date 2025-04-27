import 'dart:convert';

import 'package:cgpa/data/services/network_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger logger;
  NetworkCaller({required this.logger});

  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url,{},{},'');

      final Response response = await get(uri);
      if (response.statusCode == 200) {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          true,
        );
        // Check if the response body is null or an empty list
        if (response.body == '[]') {
          return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false, // Mark as success even if the body is empty, adjust as needed
            responseData: [],
          );
        }
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      } else {
        _responseLog(url, response.statusCode, response.body, response.headers, false,);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }
  void _requestLog(String url, Map<String, dynamic> params, Map<String, dynamic> body, String token,) {
    logger.i('''Url:$url
    Params:$params
    Body:$body
    Token:$token
    ''');
  }
  void _responseLog(String url, int statusCode, dynamic responseBody, Map<String, dynamic> headers, bool isSuccess, [dynamic error,]) {
    String massage = '''
    Url:$url
    Status Code:$statusCode
    Headers:$headers
    Response Body:$responseBody
    Error:$error
    ''';
    if (isSuccess) {
      logger.i(massage);
    } else {
      logger.e(massage);
    }
  }
}
