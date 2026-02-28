import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/card_model.dart';

import '../address_model.dart';
import '../puppy_model.dart';

class AuthResponse extends BaseResponseModel {
  AuthData? data;

  AuthResponse({super.isSuccess, this.data, super.message});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? AuthData.fromJson(json['data']) : null;
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

class AuthData {
  String? sId;
  int? createdOnDate;
  String? fullName;
  String? email;
  String? phoneNumber;
  bool? isVerified;
  bool? isGuest;
  CardModel? card;
  int? availablePoints;
  String? media;
  String? stripeId;
  int? petsCount;
  PuppyModel? pet;
  AddressModel? location;
  String? refreshToken;
  String? clientToken;
  List<Discounts>? discounts;
  List<Greetings>? greetings;

  AuthData({
    this.sId,
    this.createdOnDate,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.isVerified,
    this.media,
    this.stripeId,
    this.petsCount,
    this.pet,
    this.card,
    this.isGuest,
    this.location,
    this.availablePoints,
    this.refreshToken,
    this.discounts,
    this.clientToken,
    this.greetings,
  });

  AuthData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdOnDate = json['createdOnDate'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    isVerified = json['isVerified'];
    media = json['media'];
    stripeId = json['stripeId'];
    isGuest = json['isGuest'];
    card = json['card'] != null ? CardModel.fromJson(json['card']) : null;
    availablePoints = (json['availablePoints']).round();
    petsCount = json['petsCount'];
    pet = json['pet'] != null ? PuppyModel.fromJson(json['pet']) : null;
    location = json['location'] != null
        ? AddressModel.fromJson(json['location'])
        : null;
    refreshToken = json['refreshToken'];
    clientToken = json['clientToken'];
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(Discounts.fromJson(v));
      });
    }
    if (json['greetings'] != null) {
      greetings = <Greetings>[];
      json['greetings'].forEach((v) {
        greetings!.add(Greetings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdOnDate'] = createdOnDate;
    data['fullName'] = fullName;
    data['email'] = email;
    data['isGuest'] = isGuest;
    data['phoneNumber'] = phoneNumber;
    data['isVerified'] = isVerified;
    data['availablePoints'] = availablePoints;
    data['media'] = media;
    data['stripeId'] = stripeId;
    if (card != null) {
      data['card'] = card!.toJson();
    }
    data['petsCount'] = petsCount;
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    data['refreshToken'] = refreshToken;
    data['clientToken'] = clientToken;
    if (discounts != null) {
      data['discounts'] = discounts!.map((v) => v.toJson()).toList();
    }
    if (greetings != null) {
      data['greetings'] = greetings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Discounts {
  String? sId;
  num? createdOnDate;
  num? aggregate;
  String? name;

  Discounts({this.sId, this.createdOnDate, this.aggregate, this.name});

  Discounts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdOnDate = json['createdOnDate'];
    aggregate = json['aggregate'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdOnDate'] = createdOnDate;
    data['aggregate'] = aggregate;
    data['name'] = name;
    return data;
  }
}

class Greetings {
  String? sId;
  int? createdOnDate;
  String? title;
  String? description;
  String? type;
  List<String>? media;
  String? userId;
  bool? isFeatured;
  bool? isReplied;

  Greetings(
      {this.sId,
      this.createdOnDate,
      this.title,
      this.description,
      this.type,
      this.media,
      this.userId,
      this.isFeatured,
      this.isReplied});

  Greetings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdOnDate = json['createdOnDate'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    media = json['media'].cast<String>();
    userId = json['userId'];
    isFeatured = json['isFeatured'];
    isReplied = json['isReplied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdOnDate'] = createdOnDate;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    data['media'] = media;
    data['userId'] = userId;
    data['isFeatured'] = isFeatured;
    data['isReplied'] = isReplied;
    return data;
  }
}
