import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/services/promo_api_services.dart';
import 'package:brunos_kitchen/utils/calculations.dart';
import 'package:brunos_kitchen/view_models/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/cart_model.dart';
import '../models/recipe_model.dart';
import '../models/requests/order_request.dart';
import '../models/responses/promo_code_response.dart';
import '../utils/date_time_formatter.dart';
import '../widgets/dialogs/promo_code_validation_dialog.dart';
import 'auth_view_model.dart';

class CartViewModel with ChangeNotifier {
  final List<CartModel> _cartList = [];
  final PromoApiServices _promoApiServices = PromoApiServices();
  num _cartTotalPrice = 0;
  num _promoCodeDiscount = 0;
  num _subTotal = 0;
  PromoCodeResponse _promoCodeResponse = PromoCodeResponse();

  //num _vatValue = 0;
  double _pawPoints = 0;
  double _pawPointsAed = 0;
  double _aedPerPoint = 0;
  double _pawPointDiscount = 0;
  int _pawSelectedPoints = 0;
  int _availablePawPoints = 0;
  num _checkOutTotal = 0;
  int _deliveryFee = 0;
  num _vat = 0;
  int? _selectedIndex;
  bool _viewCartItemDetail = false;
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  DateTime _focusedDay = DateTime.now().add(const Duration(days: 4));
  DateTime _selectedDay = DateTime.now().add(const Duration(days: 4));

  // num get getVatValue => _vatValue;

  num get getVat => _vat;

  void setVat(num value) {
    _vat = value;
  }

  double get getPawPointDiscount => _pawPointDiscount;

  PromoCodeResponse get getPromoCodeResponse => _promoCodeResponse;

  void setPawPointDiscount() {
    _pawPointDiscount = _pawSelectedPoints * _aedPerPoint;
  }

  double get getAedPerPoint => _aedPerPoint;

  TextEditingController get getInstructionsController =>
      _instructionsController;

  int get getDeliveryFee => _deliveryFee;

  void setDeliveryFee(int value) {
    _deliveryFee = value;
    notifyListeners();
  }

  double get getPawPoints => _pawPoints;

  double get getPawPointsAed => _pawPointsAed;

  void addPawPoints() {
    final availablePoints = navigatorKey.currentContext!
                .read<AuthViewModel>()
                .getAuthResponse
                .data!
                .availablePoints! >=
            _availablePawPoints
        ? _availablePawPoints.toDouble()
        : navigatorKey.currentContext!
            .watch<AuthViewModel>()
            .getAuthResponse
            .data!
            .availablePoints!
            .toDouble();
    if (_pawPoints.round() < availablePoints) {
      _pawPoints = ++_pawPoints;
      setPawPoints(_pawPoints);
    }
  }

  void removePawPoints() {
    if (_pawPoints.round() > 0) {
      _pawPoints = --_pawPoints;
      setPawPoints(_pawPoints);
    }
  }

  void setPawPoints(double value) {
    _pawPoints = value;
    _pawPointsAed = _pawPoints.round() * _aedPerPoint;
    notifyListeners();
  }

  int get getAvailablePawPoints => _availablePawPoints;

  void setAvailablePawPoints({required num perAed, required num pointsLimit}) {
    _aedPerPoint = 1 / perAed;
    final discountRedeem = (_subTotal * pointsLimit / 100);
    _availablePawPoints = (discountRedeem / _aedPerPoint).floor();
    notifyListeners();
  }

  int get getPawSelectedPoints => _pawSelectedPoints;

  void setPawSelectedPoints() {
    _pawSelectedPoints = _pawPoints.round();
    // _promoCodeDiscount = 0;
    // _promoCodeController.clear();
    setPawPointDiscount();
    setCheckOutTotal();
  }

  num get getPromoCodeDiscount => _promoCodeDiscount;

  TextEditingController get getPromoCodeController => _promoCodeController;

  // int get getDeliveryCharges => _deliveryCharges;
/*
  void setDeliveryCharges (int value){
    navigatorKey.currentContext!
        .read<AuthViewModel>()
        .getAuthResponse
        .data!
        .location!
  }*/

  void setPromoCodeDiscount(int value) {
    // _pawSelectedPoints = 0;
    // _requiredPawPoints = 0;
    if (_promoCodeResponse.data!.type == 'percentage') {
      _promoCodeDiscount = _cartTotalPrice * (value / 100);
    } else {
      _promoCodeDiscount = value;
    }
    setCheckOutTotal();
  }

  num get getCheckOutTotal => _checkOutTotal;

  num get getSubTotal => _subTotal;

  void setCheckOutTotal() {
    _subTotal = _cartTotalPrice - _promoCodeDiscount - _pawPointDiscount;
    final num totalPrice = _subTotal + _deliveryFee;
    final num vatValue = navigatorKey.currentContext!
        .read<AuthViewModel>()
        .getAuthResponse
        .data!
        .discounts![6]
        .aggregate!;
    setVat((vatValue / 100) * totalPrice);

    // _vatValue = totalPrice * 5 / 100;

    // totalPrice = totalPrice + _vatValue;

    _checkOutTotal = totalPrice + _vat /*roundPrice(totalPrice.round())*/;

    notifyListeners();
  }

  clearData() {
    _promoCodeResponse.data = null;
    _promoCodeController.clear();
    _instructionsController.clear();
    _promoCodeDiscount = 0;
    _pawSelectedPoints = 0;
    _pawPointDiscount = 0;
    _availablePawPoints = 0;
  }

  bool get getViewCartItemDetail => _viewCartItemDetail;

  void setViewCartItemDetail(bool value) {
    _viewCartItemDetail = value;
    notifyListeners();
  }

  void setOrderRequest() {
    final OrderRequest orderData = OrderRequest(
      totalAmount: _checkOutTotal,
      locationId: navigatorKey.currentContext!
          .read<AuthViewModel>()
          .getAuthResponse
          .data!
          .location!
          .sId!,
      paymentMethod: navigatorKey.currentContext!
          .read<AuthViewModel>()
          .getAuthResponse
          .data!
          .card!
          .paymentMethodId!,
      discount: _promoCodeDiscount + _pawPointDiscount,
      deliveryDate: DateTimeFormatter.showDateFormat3(_selectedDay),
      promoCodeId:
          _promoCodeResponse.data != null ? _promoCodeResponse.data!.sId! : '',
      cartItems: _cartList,
      cartTotal: _cartTotalPrice,
      shippingFees: _deliveryFee,
      specialInstructions: _instructionsController.text,
      pointsUsed: _pawSelectedPoints,
      discountRatio: navigatorKey.currentContext!
          .read<AuthViewModel>()
          .getAuthResponse
          .data!
          .discounts![4]
          .aggregate!,
      vat: _vat,
    );
    navigatorKey.currentContext!
        .read<OrderViewModel>()
        .setOrderRequest(orderData);
  }

  void clearCart() {
    _selectedIndex = null;
    _cartTotalPrice = 0;
    _cartList.clear();
  }

  DateTime get getFocusedDay => _focusedDay;

  DateTime? get getSelectedDay => _selectedDay;

  List<CartModel> get getCartList => _cartList;

  num get getCartTotalPrice => _cartTotalPrice;

  int? get getSelectedIndex => _selectedIndex;

  void setSelectedIndex(int? value) {
    _selectedIndex = value;
    if (_selectedIndex != null) {
      if (_cartList[_selectedIndex!].pet != null) {
        navigatorKey.currentContext!
            .read<AuthViewModel>()
            .setPuppy(_cartList[_selectedIndex!].pet!);
      }
    }
    notifyListeners();
  }

  void onDaySelected(DateTime day, DateTime focusDay) {
    if (day.weekday != 7) {
      if (day.weekday != 6) {
        if (!isSameDay(_selectedDay, day)) {
          _selectedDay = day;
          focusDay = focusDay;
          notifyListeners();
        }
      } else {
        EasyLoading.showError('Don\'t select weakeneds');
      }
    } else {
      EasyLoading.showError('Don\'t select weakeneds');
    }
  }

  void clearDates() {
    _focusedDay = DateTime.now().add(const Duration(days: 4));
    _selectedDay = DateTime.now().add(const Duration(days: 4));
  }

  bool checkCartForPlanValidation({required String planType}) {
    // setSelectedIndex(null);
    final int index = _cartList.indexWhere((element) {
      if (element.pet != null) {
        return element.pet!.sId ==
                navigatorKey.currentContext!
                    .read<AuthViewModel>()
                    .getAuthResponse
                    .data!
                    .pet!
                    .sId! &&
            element.planType == planType;
      } else {
        return false;
      }
    });
    return index == -1 ? true : false;
  }

  bool checkProductValidation({required RecipeModel recipe}) {
    // setSelectedIndex(null);
    final int index = _cartList.indexWhere((element) =>
        element.recipes[0].sId == recipe.sId &&
        (element.recipes[0].selectedItemSize != null
            ? element.recipes[0].selectedItemSize!.name ==
                recipe.selectedItemSize!.name
            : element.recipes[0].selectedItemSize ==
                element.recipes[0].selectedItemSize));
    return index == -1 ? true : false;
  }

  void addToCartList(CartModel value) {
    if (_selectedIndex == null) {
      _cartList.add(value);
      print(_cartList);
    } else {
      _cartList[_selectedIndex!] = value;
    }
    _cartTotalPrice = calculateCartTotal(cartItems: _cartList);
    notifyListeners();
  }

  void clearCartList(CartModel value) {
    _cartList.clear();
    _cartTotalPrice = 0;
    notifyListeners();
  }

  void removeFromCartList(CartModel value) {
    _cartList.remove(value);
    _cartTotalPrice = calculateCartTotal(cartItems: _cartList);
    notifyListeners();
  }

  Future<bool> callPromoCodeApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final PromoCodeResponse response = await _promoApiServices
          .checkPromoCodeApi(code: _promoCodeController.text);
      if (response.isSuccess!) {
        _promoCodeResponse = response;
        EasyLoading.dismiss();
        if (response.data!.discount! > _subTotal) {
          promoCodeValidationDialog(
              context: navigatorKey.currentContext!,
              description:
                  'To use this promo code the cart total must be more than ${response.data!.discount!}',
              height: 200,
              title: 'Alert');
          _promoCodeController.clear();
          return false;
        } else {
          setPromoCodeDiscount(response.data!.discount!);
          return true;
        }
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
