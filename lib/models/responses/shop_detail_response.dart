import 'dart:math';

import 'package:flutter/foundation.dart';

import '../base_response_model.dart';

class ShopDetailResponse extends BaseResponseModel {
  final List<ShopDetails>? data;
  final bool? isServerError;

  ShopDetailResponse({
    super.isSuccess,
    this.data,
    this.isServerError,
    super.message,
  });

  factory ShopDetailResponse.fromJson(Map<String, dynamic> json) =>
      ShopDetailResponse(
        isSuccess: json["isSuccess"],
        data: json["data"] == null
            ? []
            : List<ShopDetails>.from(
                json["data"]!.map((x) => ShopDetails.fromJson(x))),
        isServerError: json["isServerError"],
        message: json["message"],
      );
}

class ShopDetails {
  final String? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final double? latitude;
  final double? longitude;
  final int? deliveryRadius;

  ShopDetails({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
    this.deliveryRadius,
  });

  factory ShopDetails.fromJson(Map<String, dynamic> json) => ShopDetails(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        deliveryRadius: json["deliveryRadius"],
      );

  bool isUserLocationWithinRadius(double lat, double long) {
    const R = 6371; // Radius of the earth in km
    final dLat = deg2rad(latitude! - lat);
    final dLon = deg2rad(longitude! - long);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat)) *
            cos(deg2rad(latitude!)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = R * c; // Distance in km
    debugPrint('SHOP: $latitude $longitude');
    debugPrint('USER: $lat $long');
    debugPrint('DISTANCE: $deliveryRadius $distance');
    return distance <= deliveryRadius!;
  }

  double deg2rad(double deg) {
    return deg * (pi / 180);
  }
}
