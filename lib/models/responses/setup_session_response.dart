import 'dart:convert';

import '../base_response_model.dart';

class SetupSessionResponse extends BaseResponseModel {
  final Data? data;
  final bool? isServerError;

  SetupSessionResponse({
    super.isSuccess,
    this.data,
    this.isServerError,
    super.message,
  });

  factory SetupSessionResponse.fromJson(Map<String, dynamic> json) =>
      SetupSessionResponse(
        isSuccess: json["isSuccess"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        isServerError: json["isServerError"],
        message: json["message"],
      );
}

class Data {
  final String? id;
  final String? object;
  final AdaptivePricing? adaptivePricing;
  final AutomaticTax? automaticTax;
  final BrandingSettings? brandingSettings;
  final CollectedInformation? collectedInformation;
  final int? created;
  final String? currency;
  final CustomText? customText;
  final String? customer;
  final CustomerDetails? customerDetails;
  final int? expiresAt;
  final bool? livemode;
  final Metadata? metadata;
  final String? mode;
  final String? paymentMethodCollection;
  final PaymentMethodOptions? paymentMethodOptions;
  final List<String>? paymentMethodTypes;
  final String? paymentStatus;
  final String? setupIntent;
  final String? status;
  final String? successUrl;
  final String? uiMode;
  final String? url;

  Data({
    this.id,
    this.object,
    this.adaptivePricing,
    this.automaticTax,
    this.brandingSettings,
    this.collectedInformation,
    this.created,
    this.currency,
    this.customText,
    this.customer,
    this.customerDetails,
    this.expiresAt,
    this.livemode,
    this.metadata,
    this.mode,
    this.paymentMethodCollection,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.setupIntent,
    this.status,
    this.successUrl,
    this.uiMode,
    this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        object: json["object"],
        adaptivePricing: json["adaptive_pricing"] == null
            ? null
            : AdaptivePricing.fromJson(json["adaptive_pricing"]),
        automaticTax: json["automatic_tax"] == null
            ? null
            : AutomaticTax.fromJson(json["automatic_tax"]),
        brandingSettings: json["branding_settings"] == null
            ? null
            : BrandingSettings.fromJson(json["branding_settings"]),
        collectedInformation: json["collected_information"] == null
            ? null
            : CollectedInformation.fromJson(json["collected_information"]),
        created: json["created"],
        currency: json["currency"],
        customText: json["custom_text"] == null
            ? null
            : CustomText.fromJson(json["custom_text"]),
        customer: json["customer"],
        customerDetails: json["customer_details"] == null
            ? null
            : CustomerDetails.fromJson(json["customer_details"]),
        expiresAt: json["expires_at"],
        livemode: json["livemode"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        mode: json["mode"],
        paymentMethodCollection: json["payment_method_collection"],
        paymentMethodOptions: json["payment_method_options"] == null
            ? null
            : PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes: json["payment_method_types"] == null
            ? []
            : List<String>.from(json["payment_method_types"]!.map((x) => x)),
        paymentStatus: json["payment_status"],
        setupIntent: json["setup_intent"],
        status: json["status"],
        successUrl: json["success_url"],
        uiMode: json["ui_mode"],
        url: json["url"],
      );
}

class AdaptivePricing {
  final bool? enabled;

  AdaptivePricing({
    this.enabled,
  });

  factory AdaptivePricing.fromRawJson(String str) =>
      AdaptivePricing.fromJson(json.decode(str));

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) =>
      AdaptivePricing(
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}

class AutomaticTax {
  final bool? enabled;
  final dynamic liability;
  final dynamic provider;
  final dynamic status;

  AutomaticTax({
    this.enabled,
    this.liability,
    this.provider,
    this.status,
  });

  factory AutomaticTax.fromRawJson(String str) =>
      AutomaticTax.fromJson(json.decode(str));

  factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
        enabled: json["enabled"],
        liability: json["liability"],
        provider: json["provider"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "liability": liability,
        "provider": provider,
        "status": status,
      };
}

class BrandingSettings {
  final String? backgroundColor;
  final String? borderStyle;
  final String? buttonColor;
  final String? displayName;
  final String? fontFamily;
  final dynamic icon;
  final dynamic logo;

  BrandingSettings({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });

  factory BrandingSettings.fromJson(Map<String, dynamic> json) =>
      BrandingSettings(
        backgroundColor: json["background_color"],
        borderStyle: json["border_style"],
        buttonColor: json["button_color"],
        displayName: json["display_name"],
        fontFamily: json["font_family"],
        icon: json["icon"],
        logo: json["logo"],
      );
}

class CollectedInformation {
  final dynamic businessName;
  final dynamic individualName;
  final dynamic shippingDetails;

  CollectedInformation({
    this.businessName,
    this.individualName,
    this.shippingDetails,
  });

  factory CollectedInformation.fromJson(Map<String, dynamic> json) =>
      CollectedInformation(
        businessName: json["business_name"],
        individualName: json["individual_name"],
        shippingDetails: json["shipping_details"],
      );

  Map<String, dynamic> toJson() => {
        "business_name": businessName,
        "individual_name": individualName,
        "shipping_details": shippingDetails,
      };
}

class CustomText {
  final dynamic afterSubmit;
  final dynamic shippingAddress;
  final dynamic submit;
  final dynamic termsOfServiceAcceptance;

  CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomText.fromRawJson(String str) =>
      CustomText.fromJson(json.decode(str));

  factory CustomText.fromJson(Map<String, dynamic> json) => CustomText(
        afterSubmit: json["after_submit"],
        shippingAddress: json["shipping_address"],
        submit: json["submit"],
        termsOfServiceAcceptance: json["terms_of_service_acceptance"],
      );

  Map<String, dynamic> toJson() => {
        "after_submit": afterSubmit,
        "shipping_address": shippingAddress,
        "submit": submit,
        "terms_of_service_acceptance": termsOfServiceAcceptance,
      };
}

class CustomerDetails {
  final dynamic address;
  final dynamic businessName;
  final String? email;
  final dynamic individualName;
  final dynamic name;
  final dynamic phone;
  final dynamic taxExempt;
  final dynamic taxIds;

  CustomerDetails({
    this.address,
    this.businessName,
    this.email,
    this.individualName,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  factory CustomerDetails.fromRawJson(String str) =>
      CustomerDetails.fromJson(json.decode(str));

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        address: json["address"],
        businessName: json["business_name"],
        email: json["email"],
        individualName: json["individual_name"],
        name: json["name"],
        phone: json["phone"],
        taxExempt: json["tax_exempt"],
        taxIds: json["tax_ids"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "business_name": businessName,
        "email": email,
        "individual_name": individualName,
        "name": name,
        "phone": phone,
        "tax_exempt": taxExempt,
        "tax_ids": taxIds,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromRawJson(String str) =>
      Metadata.fromJson(json.decode(str));

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class PaymentMethodOptions {
  final Card? card;

  PaymentMethodOptions({
    this.card,
  });

  factory PaymentMethodOptions.fromRawJson(String str) =>
      PaymentMethodOptions.fromJson(json.decode(str));

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "card": card?.toJson(),
      };
}

class Card {
  final String? requestThreeDSecure;

  Card({
    this.requestThreeDSecure,
  });

  factory Card.fromRawJson(String str) => Card.fromJson(json.decode(str));

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        requestThreeDSecure: json["request_three_d_secure"],
      );

  Map<String, dynamic> toJson() => {
        "request_three_d_secure": requestThreeDSecure,
      };
}
