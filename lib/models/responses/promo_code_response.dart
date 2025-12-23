import 'package:brunos_kitchen/models/base_response_model.dart';

class PromoCodeResponse extends BaseResponseModel{
  PromoData? data;

  PromoCodeResponse(
      {super.isSuccess, this.data, super.message});

  PromoCodeResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? PromoData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class PromoData {
  String? sId;
  String? name;
  int? expireOnDate;
  int? discount;
  String? type;

  PromoData({this.sId,this.name, this.expireOnDate, this.discount,this.type});

  PromoData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    expireOnDate = json['expireOnDate'];
    discount = json['discount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] =sId;
    data['name'] = name;
    data['expireOnDate'] = expireOnDate;
    data['discount'] = discount;
    data['type'] = type;
    return data;
  }
}
