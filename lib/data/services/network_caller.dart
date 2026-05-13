import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
//import 'package:get/get.dart';
//import 'package:http/http.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log(url);
    log(token.toString());

    final http.Response response = await http.get(

      Uri.parse(url),
      headers: {
        'token': token.toString(),
        'Content-type' : 'application/json'
      },
    );
    log(response.headers.toString());
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  Future<ResponseData> postRequest(String url, {Map<String, dynamic>? body}) async {
    log(url);
    log(body.toString());

    final http.Response response = await http.post(Uri.parse(url), body: jsonEncode(body));

    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}

class ResponseData {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String? errorMessage;

  ResponseData({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage,
  });
}
