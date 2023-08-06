import 'dart:convert';

import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/requests/forgot_password_request.dart';
import 'package:brunos_kitchen/models/requests/user_register_request.dart';

import '../models/requests/sign_in_request.dart';
import '../models/responses/auth_response.dart';
import '../utils/enums.dart';
import 'package:http/http.dart' as http;
import '../utils/shared_pref .dart';
import 'api_base_helper.dart';

class AuthApiServices {
  final SharedPref _sharedPref = SharedPref();

  Future<AuthResponse> signInApi({required SignInRequest signInRequest}) async {
    ApiBaseHelper httpService = ApiBaseHelper();
    final response = await httpService.httpRequest(
        endPoint: EndPoints.signIn,
        requestType: 'POST',
        requestBody: signInRequest,
        params: '');
    final parsed = json.decode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(parsed);
    if (authResponse.isSuccess!) {
      _sharedPref.save(
          SharedPreferencesKeys.authToken.text, authResponse.data!.clientToken);
    }
    return authResponse;
  }
  Future<AuthResponse> userRegisterApi({required UserRegisterRequest userRegisterRequest}) async {
    ApiBaseHelper httpService = ApiBaseHelper();
    final response = await httpService.httpRequest(
        endPoint: EndPoints.signUp,
        requestType: 'POST',
        requestBody: userRegisterRequest,
        params: '');
    final parsed = json.decode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(parsed);
    if (authResponse.isSuccess!) {
      _sharedPref.save(
          SharedPreferencesKeys.authToken.text, authResponse.data!.clientToken);
    }
    return authResponse;
  }

  Future<BaseResponseModel> forgotPasswordApi({required ForgotPasswordRequest forgotPasswordRequest}) async {
    ApiBaseHelper httpService = ApiBaseHelper();
    final response = await httpService.httpRequest(
        endPoint: EndPoints.forgotPassword,
        requestType: 'POST',
        requestBody: forgotPasswordRequest,
        params: '');
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }


}
