import 'package:brunos_kitchen/models/puppy_model.dart';

import '../utils/enums.dart';
import 'recipe_model.dart';

class CartModel {
  PuppyModel? pet;
  List<RecipeModel> recipes;
  Plans planType;
  List<num> totalWeight;
  List<String> pouchesDetail;
  num planTotal;
  num planDiscountPer;
  num planDiscountedPrice;

  CartModel({
    required this.planTotal,
    required this.recipes,
    required this.pet,
    required this.pouchesDetail,
    required this.planType,
    required this.planDiscountPer,
    required this.planDiscountedPrice,
    required this.totalWeight,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    data['pouchesDetail'] = pouchesDetail;
    data['planType'] = planType.text;
    data['planTotal'] = planTotal;
    data['planDiscountPer'] = planDiscountPer;
    data['planDiscountedPrice'] = planDiscountedPrice;
    data['totalWeight'] = totalWeight;
    data['recipes'] = recipes.map((v) => v.toJson()).toList();
    return data;
  }
}
