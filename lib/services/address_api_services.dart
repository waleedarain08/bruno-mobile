import 'dart:convert';

import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/requests/add_address_request.dart';
import 'package:brunos_kitchen/models/responses/address_radius_response.dart';
import 'package:brunos_kitchen/models/responses/places_api_response.dart';

import '../models/requests/address_radius_request.dart';
import '../models/responses/all_address_reponse.dart';
import '../utils/enums.dart';
import 'api_base_helper.dart';

class AddressApiServices {
  final ApiBaseHelper _httpService = ApiBaseHelper();

  Future<AllAddressResponse> allAddress() async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.allAddresses, requestType: 'GET', params: '');
    final parsed = json.decode(response.body);
    AllAddressResponse allAddressResponse = AllAddressResponse.fromJson(parsed);
    return allAddressResponse;
  }

  Future<AddressRadiusResponse> checkRadius(
      {required AddressRadiusRequest addressRadiusRequest}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.checkLocation,
        requestType: 'POST',
        requestBody: addressRadiusRequest,
        params: '');
    final parsed = json.decode(response.body);
    AddressRadiusResponse addressRadiusResponse =
        AddressRadiusResponse.fromJson(parsed);
    return addressRadiusResponse;
  }

  Future<BaseResponseModel> createAddress(
      {required AddAddressRequest addAddressRequest}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.addAddress,
        requestType: 'POST',
        requestBody: addAddressRequest,
        params: '');
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }

  Future<BaseResponseModel> deleteAddress({required String addressId}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.deleteAddress,
        requestType: 'DEL',
        params: addressId);
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }

  Future<BaseResponseModel> defaultAddress({required String addressId}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.defaultAddress,
        requestType: 'PUT',
        requestBody: '',
        params: addressId);
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }

  Future<PlacesApiResponse> placesSearch({required String query}) async {
    final response = await _httpService.httpRequest(
      endPoint: EndPoints.placesSearch,
      requestType: 'GET',
      params: '/$query',
    );
    final parsed = PlacesApiResponse.fromJson(json.decode(response.body));
    if (!(parsed.isSuccess ?? false)) {
      throw Exception(parsed.message);
    }
    return parsed;
  }
}
