import 'dart:math';

import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/models/puppy_model.dart';
import 'package:brunos_kitchen/models/recipe_model.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'enums.dart';

int calculateDailyIntake(
    {required RecipeModel recipeModel, required String puppyActivityLevel , required num currentWeight}) {
  final int activityLevel = puppyActivityLevel == Puppy.active.text
      ? 110
      : puppyActivityLevel == Puppy.lessActive.text
          ? 95
          : 125;

  final num dailyIntake = (activityLevel *
          pow(currentWeight, 0.75) /
          recipeModel.caloriesContentNo!) *
      1000;

  final int roundDailyIntake = dailyIntake.round();

  return roundDailyIntake;
}

int calculateFeedingPlan({required RecipeModel recipeModel, required PuppyModel puppyModel}){
  final int dailyIntake = calculateDailyIntake(recipeModel: recipeModel, puppyActivityLevel: puppyModel.activityLevel!, currentWeight: puppyModel.currentWeight!);
  final double perTime = dailyIntake/puppyModel.feedingRoutine!;
  return perTime.round();
}

