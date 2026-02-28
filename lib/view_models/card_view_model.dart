import 'dart:developer';

import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/card_model.dart';
import 'package:brunos_kitchen/models/requests/add_card_request.dart';
import 'package:brunos_kitchen/models/responses/cards_response.dart';
import 'package:brunos_kitchen/services/card_api_services.dart';
import 'package:brunos_kitchen/utils/enums.dart';
import 'package:brunos_kitchen/utils/shared_pref%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

typedef SetupIntentUrls = ({String url, String successUrl});

class CardViewModel with ChangeNotifier {
  final CardApiServices _cardApiServices = CardApiServices();
  CardsResponse _cardsResponse = CardsResponse();
  String _cardNumber = '';
  String _expiryDate = '';
  String _cardHolderName = '';
  bool _isCardAdd = false;
  String _cvvCode = '';
  bool _isDefaultCard = false;

  CardModel? _cardDetailData;
//  final CardApiServices _cardApiServices = CardApiServices();
  bool _isCvvFocused = false;
  String _cardType = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // AllCardResponse _allCardResponse = AllCardResponse();

  // AllCardResponse get getAllCardResponse => _allCardResponse;

  CardsResponse get getCardResponse => _cardsResponse;

  void setCardResponse(CardsResponse value) {
    _cardsResponse = value;
    notifyListeners();
  }

  bool get getIsCardAdd => _isCardAdd;

  bool get getIsDefaultCard => _isDefaultCard;

  String get getCardNumber => _cardNumber;

  CardModel get getCardDetailData => _cardDetailData!;

  String get getCardType => _cardType;

  String get getExpiryDate => _expiryDate;

  String get getCardHolderName => _cardHolderName;

  String get getCvvCode => _cvvCode;

  bool get getIsCvvFocused => _isCvvFocused;

  // void setAllCardResponse(AllCardResponse value) {
  //   _allCardResponse = value;
  //   notifyListeners();
  // }

  void setIsCardAdd(bool value) {
    _isCardAdd = value;
    notifyListeners();
  }

  void setIsDefaultCard(bool value) {
    _isDefaultCard = value;
    notifyListeners();
  }

  /* void setPrimaryCard(bool value) {
    _isPrimaryCard = value;
    notifyListeners();
  }*/

  void clearCardData() {
    _cardNumber = "";
    _expiryDate = "";
    _cardHolderName = "";
    _cvvCode = "";
    _isDefaultCard = false;
    notifyListeners();
  }

  void setCardDetailData(CardModel value) {
    _cardDetailData = value;
    _expiryDate = '${_cardDetailData!.expMonth!}/${_cardDetailData!.expYear!}';
    _cardNumber = '0000 0000 0000 ${_cardDetailData!.last4}';
    _cardHolderName = ' ';
    _cardType = _cardDetailData!.brand!;
    // _cvvCode = _cardDetailData!.cvc!;
    setIsDefaultCard(_cardDetailData!.isDefault!);
    notifyListeners();
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    _cardNumber = creditCardModel!.cardNumber;
    _expiryDate = creditCardModel.expiryDate;
    _cardHolderName = creditCardModel.cardHolderName;
    _cvvCode = creditCardModel.cvvCode;
    _isCvvFocused = creditCardModel.isCvvFocused;
    /* if (_cardNumber.startsWith('5')) {
      _cardTypeVisa = false;
    } else {
      _cardTypeVisa = true;
    }*/
    notifyListeners();
  }

  void onValidate() {
    if (formKey.currentState!.validate()) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  Future<bool> callAddCard() async {
    try {
      EasyLoading.show(status: 'Please Wait...');

      final List<String> expMonthYear = _expiryDate.split('/');
      print(expMonthYear);
      await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
        number: _cardNumber,
        cvc: _cvvCode,
        expirationMonth: int.parse(expMonthYear[0]),
        expirationYear: int.parse(expMonthYear[1]),
      ));

      var token = await Stripe.instance.createToken(
        CreateTokenParams.card(
          params: CardTokenParams(
            name: _cardHolderName,
            /*address: Address(
            */ /*line1: "abc",
            line2: "xyz",
            city: "Alpha",
            state: "Beta",
            country: "xy",
            postalCode: "237482",*/ /*
          ),*/
            currency: "aed",
            type: TokenType.Card,
          ),
        ),
      );

      String tokenId = token.id;

      final payment = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData.fromJson(
                {"type": "card", "card[token]": tokenId})),
      );

      print(payment.id);
      AddCardRequest addCardRequest =
          AddCardRequest(paymentMethodId: payment.id);

      final BaseResponseModel response =
          await _cardApiServices.addCardApi(addCardRequest: addCardRequest);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        await callAllCardsApi();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (exception) {
      EasyLoading.showError(exception.toString());
      return false;
    }
  }

  Future<bool> callAllCardsApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final CardsResponse response = await _cardApiServices.allCardsApi();
      if (response.isSuccess!) {
        setCardResponse(response);
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

  Future<void> addStripeCardsToUser() async {
    try {
      final stripeCustomerId =
          await SharedPref().read(SharedPreferencesKeys.stripeId.text);
      log('CUSTOMER ID: $stripeCustomerId ${stripeCustomerId == null}');
      if (stripeCustomerId == null || stripeCustomerId.isEmpty) {
        return;
      }
      EasyLoading.show(status: 'Please Wait...');
      final response =
          await _cardApiServices.allStripeCardsApi(stripeCustomerId);
      if (!(response.isSuccess ?? false)) {
        throw Exception(response.message ?? 'Something went wrong!');
      }
      final cards = _cardsResponse.data ?? <CardModel>[];
      final newCardIds = response.data.where((cardId) {
        return cards.every((card) => card.paymentMethodId != cardId);
      }).toList();
      log('NEW CARDS: $newCardIds');
      for (final cardId in newCardIds) {
        try {
          final response = await _cardApiServices.addCardApi(
            addCardRequest: AddCardRequest(
              paymentMethodId: cardId,
            ),
          );
          if (!(response.isSuccess ?? false)) {
            throw Exception('Could not add card: $cardId');
          }
          log('CARD ADDED $cardId');
        } catch (e, s) {
          log(e.toString(), stackTrace: s);
        }
      }
      if (newCardIds.isNotEmpty) {
        await callAllCardsApi();
      } else {
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future<SetupIntentUrls?> callSetupIntentApi() async {
    try {
      final stripeCustomerId =
          await SharedPref().read(SharedPreferencesKeys.stripeId.text);
      if (stripeCustomerId == null || stripeCustomerId.isEmpty) {
        return null;
      }
      EasyLoading.show(status: 'Please Wait...');
      final response = await _cardApiServices.setupIntentApi(stripeCustomerId);
      if (!(response.isSuccess ?? false)) {
        throw Exception(response.message ?? 'Something went wrong!');
      }
      EasyLoading.dismiss();
      return (url: response.data!.url!, successUrl: response.data!.successUrl!);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      EasyLoading.showError(e.toString());
      return null;
    }
  }

  Future<bool> callDeleteCard({required String cardId}) async {
    try {
      EasyLoading.show(status: 'Please Wait...');
      final BaseResponseModel response =
          await _cardApiServices.deleteCardApi(cardId: cardId);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        await callAllCardsApi();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (exception) {
      EasyLoading.showError(exception.toString());
      return false;
    }
  }

  Future<bool> callDefaultCardApi() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      final BaseResponseModel response =
          await _cardApiServices.defaultCardApi(cardId: _cardDetailData!.sId!);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        callAllCardsApi();
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
