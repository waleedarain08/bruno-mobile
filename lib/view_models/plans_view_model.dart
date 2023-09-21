import 'dart:convert';

import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/models/recipe_model.dart';
import 'package:brunos_kitchen/models/responses/recipes_list_response.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/services/plan_api_services.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:table_calendar/table_calendar.dart';

import '../screens/logIn_screen.dart';
import '../screens/intro_slides_screen.dart';
import '../utils/enums.dart';
import '../utils/calculations.dart';
import '../utils/shared_pref .dart';

class PlansViewModel with ChangeNotifier {
  final PlanApiServices _planApiServices = PlanApiServices();
  String _productCategory = "Clothing";
  int _quantity = 1;
  int _availableDays = 0;
  //bool _showDaysRangeValidation = false;
  String _planType = Plans.transitional.text;
  RecipesListResponse _recipesListResponse = RecipesListResponse();
  RecipeModel _selectedRecipe = RecipeModel();
  List<RecipeModel> _recipesList = [];
  List<RecipeModel> _productsList = [];
  List<RecipeModel> _featuredRecipesList = [];
  List<RecipeModel> _featuredProductsList = [];
  int _monthlyEmptyTileNumber = 1;
  final TextEditingController _monthlySelectedDaysController =
      TextEditingController();
  RecipeModel? _monthlyEmptyTile1;
  RecipeModel? _monthlyEmptyTile2;
  RecipeModel? _monthlyEmptyTile3;
  DateTime _focusedDay = DateTime.now().add(const Duration(days: 4));
  DateTime _selectedDay = DateTime.now().add(const Duration(days: 4));

  int get getQuantity => _quantity;

  void addQuantity (){
    _quantity = ++_quantity;
    notifyListeners();
  }

  void minusQuantity (){
    if(_quantity != 1){
    _quantity = --_quantity;
    notifyListeners();}
  }

  int get getAvailableDays => _availableDays;

//  bool get getDayRangeValidation => _showDaysRangeValidation;

  /*void setDayRangeValidation (bool value){
    _showDaysRangeValidation = value;
    notifyListeners();
  }*/

 /* bool checkAndUpdateAvailableDays (){
    final newAvailableDays = _availableDays + int.parse(_monthlySelectedDaysController.text);
    if(newAvailableDays > 30){
      _showDaysRangeValidation= true;
      notifyListeners();
      return false;
    }
    else{
      _availableDays = newAvailableDays;
      setMonthlySelectedDishModel();
      notifyListeners();
      return true;
    }
  }*/

  void setTransitionalItem() {
    final RecipeModel applyDishDetail =
    RecipeModel.fromJson(_selectedRecipe.toJson());
    applyDishDetail.finalPrice = calculateFinalPricePerDay(recipeModel: _selectedRecipe);
    _selectedRecipe = applyDishDetail;
  }

  void setSelectedItemQuantity() {
    final RecipeModel applyDishDetail =
    RecipeModel.fromJson(_selectedRecipe.toJson());
    applyDishDetail.quantity = _quantity;
    applyDishDetail.finalPrice = _selectedRecipe.pricePerKG! * _quantity;
   _selectedRecipe = applyDishDetail;
  }

  void setMonthlySelectedDishModel() {
    final RecipeModel applyDishDetail =
    RecipeModel.fromJson(_selectedRecipe.toJson());
    applyDishDetail.totalDays = int.parse(_monthlySelectedDaysController.text);
    applyDishDetail.quantity = _quantity;
   applyDishDetail.finalPrice = calculateFinalPricePerDay(recipeModel: _selectedRecipe)*int.parse(_monthlySelectedDaysController.text);
    if (_monthlyEmptyTileNumber == 1) {
      _monthlyEmptyTile1 = applyDishDetail;
    } else if (_monthlyEmptyTileNumber == 2) {
      _monthlyEmptyTile2 = applyDishDetail;
    } else {
      _monthlyEmptyTile3 = applyDishDetail;
    }
  }


  String get getProductCategory => _productCategory;

  void setProductCategory (String value){
    _productCategory = value;
    _productsList = _recipesListResponse.data!.recipe!.where((element) => element.category! == _productCategory).toList();
    notifyListeners();
  }

  List<RecipeModel> get getFeaturedRecipesList => _featuredRecipesList;

  List<RecipeModel> get getFeaturedProductList => _featuredProductsList;

  List<RecipeModel> get getRecipesList => _recipesList;

  List<RecipeModel> get getProductList => _productsList;

  RecipesListResponse get getRecipesListResponse => _recipesListResponse;


  void setRecipesListResponse(RecipesListResponse value) {
    _recipesListResponse = value;
    _recipesList = _recipesListResponse.data!.recipe!.where((element) => element.category!.isEmpty).toList();
    _productsList = _recipesListResponse.data!.recipe!.where((element) => element.category! == _productCategory).toList();
    _featuredRecipesList = _recipesListResponse.data!.recipe!.where((element) => element.category!.isEmpty && element.isFeatured!).toList();
    _featuredProductsList = _recipesListResponse.data!.recipe!.where((element) => element.category!.isNotEmpty && element.isFeatured!).toList();
    notifyListeners();
  }

  int get getMonthlyEmptyTileNumber => _monthlyEmptyTileNumber;

  void setMonthlyEmptyTileNumber(int value) {
    _monthlyEmptyTileNumber = value;
    notifyListeners();
  }

  RecipeModel get getSelectedRecipe => _selectedRecipe;

  void setSelectedRecipe(RecipeModel value) {
    _selectedRecipe = value;
    notifyListeners();
  }

  TextEditingController get getMonthlySelectedDaysController =>
      _monthlySelectedDaysController;

  RecipeModel? get getMonthlyEmptyTile1 => _monthlyEmptyTile1;

  RecipeModel? get getMonthlyEmptyTile2 => _monthlyEmptyTile2;

  RecipeModel? get getMonthlyEmptyTile3 => _monthlyEmptyTile3;


  DateTime get getFocusedDay => _focusedDay;

  DateTime? get getSelectedDay => _selectedDay;

  String get getPlanType => _planType;

  void setPlanType(String value) {
    _planType = value;
    notifyListeners();
  }

  void clearPlanData() {
    _quantity = 1;
    _availableDays = 0;
    _monthlySelectedDaysController.clear();
    _monthlyEmptyTileNumber = 1;
    _monthlyEmptyTile1 = null;
    _monthlyEmptyTile2 = null;
    _monthlyEmptyTile3 = null;
    _focusedDay = DateTime.now().add(const Duration(days: 4));
    _selectedDay = DateTime.now().add(const Duration(days: 4));
    notifyListeners();
  }

  void onDaySelected(DateTime day, DateTime focusDay) {
    if (!isSameDay(_selectedDay, day)) {
      _selectedDay = day;
      focusDay = focusDay;
      notifyListeners();
    }
  }

  Future<bool> callAllRecipesApi() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      final RecipesListResponse response = await _planApiServices.allRecipes();
      if (response.isSuccess!) {
        setRecipesListResponse(response);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }
}
