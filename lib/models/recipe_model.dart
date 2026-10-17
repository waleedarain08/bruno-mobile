import 'dart:convert';

import 'ingredient_model.dart';
import 'item_sizes_model.dart';
import 'custom_prices_model.dart';

class RecipeModel {
  String? sId;
  String? productImage;
/*
  int? createdOnDate;
*/
  String? name;
  bool? isFeatured;
  String? standaloneSize;
  String? unit;


/*
  String? userId;
*/
  List<Ingredient>? ingredient;
  String? description;
  String? details;

  //String? brand;
  int? weight;
  String? instructions;
  List<String>? nutrition;
  num? pricePerKG;
  /*num? price1;
  num? price2;
  num? price3;
  num? price4;
  num? price5;
  num? price6;*/
  bool? isComboRecipe;
  num? finalPrice;
  List<String>? media;
  List<ItemSizes>? sizes;
  ItemSizes? selectedItemSize;
  String? recipeNo;
  List<String>? tableImage;
  String? lifeStage;
  int? totalDays;
  int? quantity;
  String? category;
  int? caloriesContentNo;

  // Ingredient? ingredient;
  String? ingredientsComposition;
  List<CustomPricesModel>? monthlyPrices;
  List<CustomPricesModel>? transitionalPrices;

  RecipeModel(
      {this.sId,
/*
        this.createdOnDate,
*/
      this.name,
      this.isFeatured,
/*
        this.userId,
*/
      this.ingredient,
      this.tableImage,
      this.description,
      this.details,
      this.instructions,
      this.nutrition,
      this.pricePerKG,
   /*   this.price1,
      this.price2,
      this.price3,
      this.price4,
      this.price5,
      this.price6,*/
      this.media,
      this.recipeNo,
      this.lifeStage,
      this.caloriesContentNo,
      this.quantity,
      this.finalPrice,
      this.isComboRecipe,
      this.sizes,
        this.unit,
        this.productImage,
      // this.brand,
      this.weight,
      this.selectedItemSize,
      // this.ingredients,
      this.totalDays,
      this.category,
      this.ingredientsComposition,
      this.standaloneSize,
        this.monthlyPrices,
        this.transitionalPrices});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
/*
    createdOnDate = json['createdOnDate'];
*/
    productImage = json['productImage'];
    name = json['name'];
    unit = json['unit'];
    //  brand = json['brand'] ?? '';
    weight = json['weight'];
    isFeatured = json['isFeatured'];
/*
    userId = json['userId'];
*/
    finalPrice = json['finalPrice'] ?? json['pricePerKG'];
    if (json['ingredient'] != null) {
      ingredient = <Ingredient>[];
      json['ingredient'].forEach((v) {
        ingredient!.add(Ingredient.fromJson(v));
      });
    }
    description = json['description'];
    isComboRecipe = json['isComboRecipe'] ?? false;
    totalDays = json['totalDays'] ?? 1;
    quantity = json['quantity'] ?? 1;
    details = json['details'];
    instructions = json['instructions'];
    nutrition = json['nutrition'].split(",");
    if (json['sizes'] != null) {
      sizes = <ItemSizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(ItemSizes.fromJson(v));
      });
      if (sizes!.isNotEmpty) {
        selectedItemSize = sizes![0];
        pricePerKG = sizes![0].price;
      } else {
        pricePerKG = json['pricePerKG'];
      }
    } else {
      sizes = <ItemSizes>[];
      pricePerKG = json['pricePerKG'];
    }
   /* price1 = json['price1'];
    price2 = json['price2'];
    price3 = json['price3'];
    price4 = json['price4'];
    price5 = json['price5'];
    price6 = json['price6'];*/
    media = json['media'].cast<String>();
    tableImage =
        json['tableImage'] != null ? json['tableImage'].cast<String>() : [];
    category = json['category'];
    recipeNo = json['recipeNo'];
    lifeStage = json['lifeStage'];
    caloriesContentNo = json['caloriesContentNo'];
    //  ingredients = json['ingredients'];
    ingredientsComposition = json['ingredientsComposition'];
    standaloneSize = json['standaloneSize'];
    if (json['monthlyPrices'] != null) {
      monthlyPrices = <CustomPricesModel>[];
      json['monthlyPrices'].forEach((v) {
        monthlyPrices!.add(CustomPricesModel.fromJson(v));
      });
    }
    if (json['transitionalPrices'] != null) {
      transitionalPrices = <CustomPricesModel>[];
      json['transitionalPrices'].forEach((v) {
        transitionalPrices!.add(CustomPricesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
/*
    data['createdOnDate'] = this.createdOnDate;
*/
    // data['brand'] = this.brand;
    data['productImage'] = productImage;
    data['weight'] = weight;
    data['unit'] = unit;
    data['name'] = name;
    data['isFeatured'] = isFeatured;
    data['isComboRecipe'] = isComboRecipe;
    data['standaloneSize'] = standaloneSize;
/*
    data['userId'] = this.userId;
*/
    data['totalDays'] = totalDays ?? 1;
    data['quantity'] = quantity ?? 1;
    data['finalPrice'] = finalPrice ?? pricePerKG;
    if (ingredient != null) {
      data['ingredient'] = ingredient!.map((v) => v.toJson()).toList();
    }
    if (nutrition != null) {
      data['nutrition'] = jsonEncode(nutrition);
    }
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    data['selectedItemSize'] = selectedItemSize;
    data['description'] = description;
    data['tableImage'] = tableImage;
    data['details'] = details;
    data['instructions'] = instructions;
    // data['nutrition'] = this.nutrition;
  /*  data['price1'] = this.price1;
    data['price2'] = this.price2;
    data['price3'] = this.price3;
    data['price4'] = this.price4;
    data['price5'] = this.price5;
    data['price6'] = this.price6;*/
    data['pricePerKG'] = pricePerKG;
    data['media'] = media;
    data['recipeNo'] = recipeNo;
    data['lifeStage'] = lifeStage;
    data['category'] = category;
    data['caloriesContentNo'] = caloriesContentNo;
    //  data['ingredients'] = this.ingredients;
    data['ingredientsComposition'] = ingredientsComposition;
    if (monthlyPrices != null) {
      data['monthlyPrices'] =
          monthlyPrices!.map((v) => v.toJson()).toList();
    }
    if (transitionalPrices != null) {
      data['transitionalPrices'] =
          transitionalPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  int get stock {
    if (sizes == null) {
      return 0;
    }
    return sizes!.fold(0, (total, next) {
      return total + (next.stock ?? 0);
    });
  }
}
