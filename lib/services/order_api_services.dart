import 'dart:convert';

import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/requests/order_request.dart';
import 'package:brunos_kitchen/models/responses/order_response.dart';
import '../utils/enums.dart';
import 'api_base_helper.dart';

class OrderApiServices {
  final ApiBaseHelper _httpService = ApiBaseHelper();
  Future<BaseResponseModel> createOrderApi({required OrderRequest orderRequest}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.createOrder,
        requestType: 'POST',
        requestBody: orderRequest,
        params: '');
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }

  Future<OrderResponse> allOrderApi() async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.allOrder,
        requestType: 'GET',
        params: '');
    final parsed = json.decode(response.body);
    OrderResponse orderResponse = OrderResponse.fromJson(parsed);
    return orderResponse;
  }

}