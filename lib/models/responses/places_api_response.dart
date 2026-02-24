import 'package:brunos_kitchen/models/base_response_model.dart';

class PlacesApiResponse extends BaseResponseModel {
  final List<Place>? data;
  final bool? isServerError;

  PlacesApiResponse({
    super.isSuccess,
    this.data,
    this.isServerError,
    super.message,
  });

  factory PlacesApiResponse.fromJson(Map<String, dynamic> json) =>
      PlacesApiResponse(
        isSuccess: json["isSuccess"],
        data: json["data"] == null
            ? []
            : List<Place>.from(json["data"]!.map((x) => Place.fromJson(x))),
        isServerError: json["isServerError"],
        message: json["message"],
      );
}

class Place {
  final String? place;
  final String? placeId;
  final Text? text;

  Place({
    this.place,
    this.placeId,
    this.text,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        place: json["place"],
        placeId: json["placeId"],
        text: json["text"] == null ? null : Text.fromJson(json["text"]),
      );
}

class Text {
  final String? text;

  Text({
    this.text,
  });

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        text: json["text"],
      );
}
