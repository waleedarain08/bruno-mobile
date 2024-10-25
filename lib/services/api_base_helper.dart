import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../utils/enums.dart';
import '../utils/shared_pref .dart';

class ApiBaseHelper {
  SharedPref sharedPref = SharedPref();
  static const _baseURL =
     // 'http://10.120.10.159:8000/api/';
      'https://staging.appedology.pk/helplink/public/api/';
   String? autToken;

  Future<dynamic> httpRequest(
      {required EndPoints endPoint, required String requestType, var requestBody, required String params, String? imagePath}) async {
    autToken = await sharedPref.read(
        SharedPreferencesKeys.authToken.text);
    print(autToken);
    try {
      switch (requestType) {
        case 'GET':
          final responseJson = await http.get(
            Uri.parse(_baseURL + endPoint.url + params),
            headers: getHeaders(),
          );
          return responseJson;
        case 'POST':
          final responseJson = await http.post(
              Uri.parse(_baseURL + endPoint.url),
              headers: getHeaders(),
              body: jsonEncode(requestBody)
          );
          return responseJson;

        case 'MULTIPART':
          final request = http.MultipartRequest('POST',  Uri.parse(_baseURL + endPoint.url));
          request.fields.addAll(requestBody!.toJson());
          request.files.add(await http.MultipartFile.fromPath('image', imagePath!));
          request.headers.addAll(getHeaders());
          final responseJson = await request.send();
          return responseJson;
      }
    } on SocketException {
      EasyLoading.showError('No Internet          Connection');
    } on HttpException {
      EasyLoading.showError('No Internet Connection');
    } on FormatException {
      EasyLoading.showError('Invalid Format');
    } on TimeoutException {
      EasyLoading.showError('Request TimeOut');
    }
    catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Map<String, String> getHeaders() {

    Map<String, String> headers = {};
    headers.putIfAbsent('Content-Type', () => 'application/json');
    headers.putIfAbsent('Accept', () => 'application/json');
    headers.putIfAbsent('Authorization', () => 'Bearer ${autToken?? ''}');
    return headers;
  }


}
