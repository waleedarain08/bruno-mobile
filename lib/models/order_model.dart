import 'package:brunos_kitchen/models/puppy_model.dart';
import 'package:brunos_kitchen/models/recipe_model.dart';

import '../utils/enums.dart';

class OrderData {
  String? sId;
  num? totalAmount;
  String? locationId;
  String? paymentMethod;
  num? discount;
  num? vat;
  String? deliveryDate;
  num? createdOnDate;
  String? promoCodeId;
  bool? isCompleted;
  num? shippingFees;
  num? cartTotal;
  num? pointsEarned;
  List<OrderItems>? orderItems;

  OrderData(
      {this.sId,
      this.totalAmount,
      this.locationId,
      this.paymentMethod,
      this.discount,
      this.deliveryDate,
      this.promoCodeId,
      this.cartTotal,
      this.vat,
      this.createdOnDate,
      this.shippingFees,
      this.isCompleted,
      this.pointsEarned,
      this.orderItems});

  OrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalAmount = json['totalAmount'];
    locationId = json['locationId'];
    paymentMethod = json['paymentMethod'];
    discount = json['discount'];
    deliveryDate = json['deliveryDate'];
    cartTotal = json['cartTotal'];
    createdOnDate = json['createdOnDate'];
    shippingFees = json['shippingFees'];
    isCompleted = json['isCompleted'];
    promoCodeId = json['promoCodeId'];
    vat = json['vat'];
    pointsEarned = json['pointsEarned'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['totalAmount'] = totalAmount;
    data['locationId'] = locationId;
    data['paymentMethod'] = paymentMethod;
    data['discount'] = discount;
    data['deliveryDate'] = deliveryDate;
    data['shippingFees'] = shippingFees;
    data['isCompleted'] = isCompleted;
    data['isCompleted'] = isCompleted;
    data['vat'] = vat;
    data['pointsEarned'] = pointsEarned;
    data['promoCodeId'] = promoCodeId;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  PuppyModel? pet;
  List<String>? pouchesDetail;
  Plans? planType;
  num? planTotal;
  num? planDiscountPer;
  num? planDiscountedPrice;
  List<num>? totalWeight;
  List<RecipeModel>? recipes;

  OrderItems(
      {this.pet,
      this.pouchesDetail,
      this.planType,
      this.planTotal,
      this.planDiscountPer,
      this.planDiscountedPrice,
      this.totalWeight,
      this.recipes});

  OrderItems.fromJson(Map<String, dynamic> json) {
    pet = json['pet'] != null ? PuppyModel.fromJson(json['pet']) : null;
    pouchesDetail = json['pouchesDetail'].cast<String>();
    planType =
        json['planType'] != null ? Plans.values.byName(json['planType']) : null;
    planTotal = json['planTotal'];
    planDiscountPer = json['planDiscountPer'];
    planDiscountedPrice = json['planDiscountedPrice'];
    totalWeight = json['totalWeight'].cast<int>();
    if (json['recipes'] != null) {
      recipes = <RecipeModel>[];
      json['recipes'].forEach((v) {
        recipes!.add(RecipeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    data['pouchesDetail'] = pouchesDetail;
    data['planType'] = planType?.text;
    data['planTotal'] = planTotal;
    data['planDiscountPer'] = planDiscountPer;
    data['planDiscountedPrice'] = planDiscountedPrice;
    data['totalWeight'] = totalWeight;
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
