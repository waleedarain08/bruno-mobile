import 'package:brunos_kitchen/models/base_response_model.dart';

import '../order_model.dart';

class OrderCreateResponse extends BaseResponseModel{
    OrderData? data;

  OrderCreateResponse({super.isSuccess, this.data, super.message});

  OrderCreateResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
