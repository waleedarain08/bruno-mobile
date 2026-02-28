import 'package:brunos_kitchen/models/base_response_model.dart';

class StripeCardsResponse extends BaseResponseModel {
  final List<String> data;

  StripeCardsResponse({super.isSuccess, super.message, required this.data});

  factory StripeCardsResponse.fromJson(Map<String, dynamic> json) =>
      StripeCardsResponse(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<String>.from(json["data"].map((x) => x)),
      );
}
