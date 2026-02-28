import 'dart:convert';

import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/responses/cards_response.dart';
import 'package:brunos_kitchen/models/responses/setup_session_response.dart';

import '../models/requests/add_card_request.dart';
import '../models/responses/stripe_cards_response.dart';
import '../utils/enums.dart';
import 'api_base_helper.dart';

class CardApiServices {
  final ApiBaseHelper _httpService = ApiBaseHelper();

  Future<BaseResponseModel> addCardApi(
      {required AddCardRequest addCardRequest}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.addCard,
        requestType: 'POST',
        requestBody: addCardRequest,
        params: '');
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }

  Future<CardsResponse> allCardsApi() async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.allCards, requestType: 'GET', params: '');
    final parsed = json.decode(response.body);
    CardsResponse cardsResponse = CardsResponse.fromJson(parsed);
    return cardsResponse;
  }

  Future<StripeCardsResponse> allStripeCardsApi(String stripeCustomerId) async {
    final response = await _httpService.httpRequest(
      endPoint: EndPoints.allStripeCards,
      requestType: 'GET',
      params: stripeCustomerId,
    );
    final parsed = json.decode(response.body);
    return StripeCardsResponse.fromJson(parsed);
  }

  Future<SetupSessionResponse> setupIntentApi(String stripeCustomerId) async {
    final response = await _httpService.httpRequest(
      endPoint: EndPoints.setupIntent,
      requestType: 'GET',
      params: stripeCustomerId,
    );
    final parsed = json.decode(response.body);
    return SetupSessionResponse.fromJson(parsed);
  }

  Future<BaseResponseModel> deleteCardApi({required String cardId}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.deleteCard, requestType: 'DEL', params: cardId);
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }

  Future<BaseResponseModel> defaultCardApi({required String cardId}) async {
    final response = await _httpService.httpRequest(
        endPoint: EndPoints.defaultCard,
        requestType: 'PUT',
        requestBody: '',
        params: cardId);
    final parsed = json.decode(response.body);
    BaseResponseModel baseResponseModel = BaseResponseModel.fromJson(parsed);
    return baseResponseModel;
  }
}
