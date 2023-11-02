import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/requests/add_card_request.dart';
import 'package:brunos_kitchen/models/responses/cards_response.dart';
import 'package:brunos_kitchen/services/card_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CardViewModel with ChangeNotifier {
  final CardApiServices _cardApiServices = CardApiServices();
  CardsResponse _cardsResponse = CardsResponse();
  String _cardNumber = '';
  String _expiryDate = '';
  String _cardHolderName = '';
  bool _isCardAdd = false;
  String _cvvCode = '';
  bool _isPrimaryCard = false;

  // CardDetailData? _cardDetailData;
//  final CardApiServices _cardApiServices = CardApiServices();
  bool _isCvvFocused = false;
  bool _cardTypeVisa = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // AllCardResponse _allCardResponse = AllCardResponse();

  // AllCardResponse get getAllCardResponse => _allCardResponse;

  CardsResponse get getCardResponse => _cardsResponse;

  void setCardResponse (CardsResponse value){
    _cardsResponse = value;
    notifyListeners();
  }

  bool get getIsCardAdd => _isCardAdd;

  bool get getIsPrimaryCard => _isPrimaryCard;

  String get getCardNumber => _cardNumber;

  // CardDetailData get getCardDetailData => _cardDetailData!;

  bool get getCardTypeVisa => _cardTypeVisa;

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

  void setPrimaryCard(bool value) {
    _isPrimaryCard = value;
    notifyListeners();
  }

  void clearCardData() {
    _cardNumber = "";
    _expiryDate = "";
    _cardHolderName = "";
    _cvvCode = "";
    notifyListeners();
  }

  // void setCardDetailData(CardDetailData value) {
  //   _cardDetailData = value;
  //   _expiryDate = _cardDetailData!.expDate!;
  //   _cardNumber = '0000 0000 0000 ${_cardDetailData!.endFourDigit}';
  //   _cardHolderName = _cardDetailData!.cardHolder!;
  //   _cvvCode = _cardDetailData!.cvc!;
  //   setPrimaryCard(_cardDetailData!.isPrimary!);
  //   notifyListeners();
  // }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    _cardNumber = creditCardModel!.cardNumber;
    _expiryDate = creditCardModel.expiryDate;
    _cardHolderName = creditCardModel.cardHolderName;
    _cvvCode = creditCardModel.cvvCode;
    _isCvvFocused = creditCardModel.isCvvFocused;
    if (_cardNumber.startsWith('5')) {
      _cardTypeVisa = false;
    } else {
      _cardTypeVisa = true;
    }
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
      AddCardRequest addCardRequest = AddCardRequest(cardPM: payment.id, cardHolder: _cardHolderName);

      final BaseResponseModel response =
          await _cardApiServices.addCardApi(addCardRequest: addCardRequest);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
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

  Future<bool> callCardsApi() async {
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
}
