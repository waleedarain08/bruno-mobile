import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/view_models/address_view_model.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/card_view_model.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/date_time_formatter.dart';
import '../utils/images.dart';
import '../utils/widget_utils.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/bottomSheet/redeem_paw_points_bottom_sheet_widget.dart';
import '../widgets/dialogs/checkout_confirmation_dialog.dart';
import '../widgets/dialogs/discription_dialog.dart';
import '../widgets/labeled_bottom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartViewModel>().clearData();
      context.read<CartViewModel>().setCheckOutTotal();
      context.read<AddressViewModel>().setIsAddressAdd(false);
      context.read<AddressViewModel>().setEditAddress(
          value: context.read<AuthViewModel>().getAuthResponse.data!.location!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, cartViewModel, child) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
              heading: 'CheckOut', showPuppy: false, showCart: false),
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: context.isBiggerThanMobile
                      ? MediaQuery.widthOf(context) * 0.4
                      : null,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20, bottom: 300)
                          .w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Image.asset(
                              buyBulits3,
                              height: 57.h,
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          black24w500Centre(data: 'Checkout'),
                          SizedBox(
                            height: 10.h,
                          ),
                          lightBlack14w400Centre(
                              data:
                                  'You’re just two clicks away to serve up the finest meals tailored for your fluffy companion\'s ultimate joy'),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: CustomColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50, color: CustomColors.greyColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20).w,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        mapPin,
                                        color: CustomColors.orangeColor,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      lightBlack14w400Centre(
                                          data: 'Delivery Address'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  context
                                              .read<AuthViewModel>()
                                              .getAuthResponse
                                              .data!
                                              .location !=
                                          null
                                      ? SizedBox(
                                          height: 130.h,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: GoogleMap(
                                              // zoomControlsEnabled: false,
                                              //liteModeEnabled: true,
                                              // myLocationEnabled: true,
                                              // myLocationButtonEnabled: true,
                                              mapType: MapType.terrain,
                                              initialCameraPosition: CameraPosition(
                                                  target: LatLng(
                                                      double.parse(context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location!
                                                          .coordinates![0]),
                                                      double.parse(context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location!
                                                          .coordinates![1]))),
                                              markers: <Marker>{
                                                Marker(
                                                  markerId: const MarkerId("1"),
                                                  position: LatLng(
                                                      double.parse(context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location!
                                                          .coordinates![0]),
                                                      double.parse(context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location!
                                                          .coordinates![1])),
                                                  icon: BitmapDescriptor
                                                      .defaultMarkerWithHue(
                                                          BitmapDescriptor
                                                              .hueOrange),
                                                  infoWindow: const InfoWindow(
                                                    title: '',
                                                  ),
                                                )
                                              },
                                              onMapCreated: context
                                                  .read<AddressViewModel>()
                                                  .getUserLocation,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 240.w,
                                              child: black18w500(
                                                  data: context
                                                              .read<
                                                                  AuthViewModel>()
                                                              .getAuthResponse
                                                              .data!
                                                              .location !=
                                                          null
                                                      ? context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location!
                                                          .address!
                                                      : 'Click to add Address')),
                                          context
                                                      .read<AuthViewModel>()
                                                      .getAuthResponse
                                                      .data!
                                                      .location !=
                                                  null
                                              ? SizedBox(
                                                  width: 240.w,
                                                  child: lightBlack14w400Centre(
                                                      left: true,
                                                      data: context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location!
                                                          .flatHouseNumber!))
                                              : SizedBox(),
                                          context
                                                      .read<AuthViewModel>()
                                                      .getAuthResponse
                                                      .data!
                                                      .location !=
                                                  null
                                              ? orange18w500(
                                                  data: context
                                                      .read<AuthViewModel>()
                                                      .getAuthResponse
                                                      .data!
                                                      .location!
                                                      .label!)
                                              : SizedBox()
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<AddressViewModel>()
                                              .setRouteFromHome(false);
                                          context
                                                      .read<AuthViewModel>()
                                                      .getAuthResponse
                                                      .data!
                                                      .location !=
                                                  null
                                              ? Navigator.pushNamed(
                                                  context, addressRoute)
                                              : {
                                                  context
                                                      .read<AddressViewModel>()
                                                      .setIsAddressAdd(true),
                                                  Navigator.pushNamed(
                                                      context, addAddressRoute)
                                                };
                                        },
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            color: CustomColors.whiteColor,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 0.75,
                                                  color: CustomColors
                                                      .greyMediumColor),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10).w,
                                            child: Icon(
                                              context
                                                          .read<AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .location !=
                                                      null
                                                  ? Icons.edit
                                                  : Icons.add,
                                              size: 20,
                                              color: CustomColors.orangeColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          TextField(
                            controller: cartViewModel.getInstructionsController,
                            onChanged: (text) {},
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: CustomColors.greyColor, width: 0.50),
                              ),
                              hintText: 'Special Instructions',
                              hintStyle: const TextStyle(
                                  color: CustomColors.blackColor),
                              contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15.0)
                                  .w,
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: CustomColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50, color: CustomColors.greyColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(20).w,
                                child: lightBlack14w400Centre(
                                    data:
                                        'Expected delivery date on or before: ${DateTimeFormatter.showDateFormat4(cartViewModel.getSelectedDay!)}'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CardViewModel>().clearCardData();
                              context.read<CardViewModel>().setIsCardAdd(true);
                              Navigator.pushNamed(context, chooseCardRoute);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: CustomColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50,
                                      color: CustomColors.greyColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20).w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(payCardIcon),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    context
                                                .watch<AuthViewModel>()
                                                .getAuthResponse
                                                .data!
                                                .card !=
                                            null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              orange18w500(
                                                  data: context
                                                      .watch<AuthViewModel>()
                                                      .getAuthResponse
                                                      .data!
                                                      .card!
                                                      .brand!),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              grey12w500(
                                                  data:
                                                      '**** **** **** ${context.watch<AuthViewModel>().getAuthResponse.data!.card!.last4}'),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              grey12w500(
                                                  data:
                                                      'Expiry: ${context.watch<AuthViewModel>().getAuthResponse.data!.card!.expMonth}/${context.watch<AuthViewModel>().getAuthResponse.data!.card!.expYear}'),
                                            ],
                                          )
                                        : lightBlack14w400Centre(
                                            data: 'Payment method'),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15,
                                      color: CustomColors.greyColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          /* Container(
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: CustomColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50, color: CustomColors.greyColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  black18w500(data: 'Order Summary'),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      lightBlack14w400Centre(data: 'Subtotal'),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      lightBlack14w400Centre(
                                          data:
                                              'AED ${cartViewModel.getCartTotalPrice}'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      lightBlack14w400Centre(data: 'Delivery Fee'),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      lightBlack14w400Centre(
                                          data:
                                              '${cartViewModel.getDeliveryFee} AED (One time  Fee)'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),*/
                          InkWell(
                            onTap: context
                                        .watch<AuthViewModel>()
                                        .getAuthResponse
                                        .data!
                                        .availablePoints !=
                                    0
                                ? () {
                                    cartViewModel.setAvailablePawPoints(
                                        perAed: context
                                            .read<AuthViewModel>()
                                            .getAuthResponse
                                            .data!
                                            .discounts![5]
                                            .aggregate!,
                                        pointsLimit: context
                                            .read<AuthViewModel>()
                                            .getAuthResponse
                                            .data!
                                            .discounts![2]
                                            .aggregate!);
                                    cartViewModel.setPawPoints(0);
                                    redeemPawPointsBottomSheetWidget();
                                  }
                                : () {},
                            child: Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: CustomColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50,
                                      color: CustomColors.greyColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20).w,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      couponCoin,
                                      height: 40.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Visibility(
                                      visible: context
                                              .watch<AuthViewModel>()
                                              .getAuthResponse
                                              .data!
                                              .availablePoints !=
                                          0,
                                      replacement: SizedBox(
                                        width: 200.w,
                                        child: black12w500Centre(
                                            data:
                                                'You don\'t have any accumulated Paw Points'),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          black12w500Centre(
                                              data:
                                                  'Your accumulated Paw Points'),
                                          black16w500(
                                              data: context
                                                  .watch<AuthViewModel>()
                                                  .getAuthResponse
                                                  .data!
                                                  .availablePoints
                                                  .toString()),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Visibility(
                                      visible: context
                                              .watch<AuthViewModel>()
                                              .getAuthResponse
                                              .data!
                                              .availablePoints !=
                                          0,
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15,
                                        color: CustomColors.greyColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: CustomColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50, color: CustomColors.greyColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20).w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  black18w500(data: 'Having a Promo Code?'),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  lightBlack14w400Centre(
                                      left: true,
                                      data:
                                          'You can apply the given Promo Code here and claim your special discount. Promo Codes are one-time use only.'),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  /* Row(
                                    children: [
                                      lightBlack14w400Centre(
                                          data: 'Generate coupon code'),
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {
                                            descriptionDialog(
                                                context: context,
                                                description:
                                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic',
                                                height: 300,
                                                title: 'Description');
                                          },
                                          child: orange14w400(data: 'How it works?')),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),*/
                                  TextField(
                                    controller:
                                        cartViewModel.getPromoCodeController,
                                    onChanged: (value) {
                                      // puppyViewModel.searchBreeds(value);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(16.0).w,
                                          child: SvgPicture.asset(couponIcon),
                                        ),
                                        /*suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 25,
                                ),*/
                                        contentPadding:
                                            const EdgeInsets.all(20.0).w,
                                        hintText: 'Code'),
                                  ),
                                  /* Container(
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: CustomColors.greyMediumLightColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(couponIcon),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          lightBlack14w400Centre(data: 'ME432DW'),
                                        ],
                                      ),
                                    ),
                                  ),*/
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      cartViewModel
                                          .callPromoCodeApi()
                                          .then((value) {
                                        if (value) {
                                          /* if (cartViewModel.getPromoCodeDiscount >
                                              cartViewModel.getCartTotalPrice) {
                                            promoCodeValidationDialog(
                                                context: context,
                                                description:
                                                    'To use this promo code the cart total must be more than ${cartViewModel.getPromoCodeDiscount}',
                                                height: 200,
                                                title: 'Alert');
                                          } else {*/
                                          cartViewModel.setCheckOutTotal();
                                          /*   }*/
                                        }
                                      });
                                      //cartViewModel.setPromoCodeDiscount(value);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: ShapeDecoration(
                                        color: CustomColors.whiteColor,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: CustomColors.greyColor),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20).w,
                                        child: lightBlack14w400Centre(
                                            data: 'Apply coupon code'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              LabeledBottomButton(
                isButtonVisible: MediaQuery.of(context).viewInsets.bottom == 0,
                label: _buildButtonLabel(cartViewModel),
                buttonText: 'Place Order',
                onTap: () {
                  if (context
                          .read<AuthViewModel>()
                          .getAuthResponse
                          .data!
                          .card ==
                      null) {
                    descriptionDialog(
                        context: context,
                        description: 'Kindly Select Payment Method',
                        height: 200.h,
                        title: 'Alert');
                  } else if (context
                          .read<AuthViewModel>()
                          .getAuthResponse
                          .data!
                          .location ==
                      null) {
                    descriptionDialog(
                        context: context,
                        description: 'Kindly Select Location',
                        height: 150.h,
                        title: 'Alert');
                  } else {
                    checkOutConfirmationDialog(context: context);
                  }
                },
              ),
              // Visibility(
              //   visible: MediaQuery.of(context).viewInsets.bottom == 0,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       decoration: const BoxDecoration(
              //         color: CustomColors.whiteColor,
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(30.0),
              //           topRight: Radius.circular(30.0),
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //             offset: Offset(0, 0),
              //             blurRadius: 5,
              //             spreadRadius: 2,
              //             color: Colors.black12,
              //           ),
              //         ],
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(20).w,
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             /* Row(
              //               children: [
              //                 lightBlack14w400Centre(
              //                     data: 'Points Rewarded Amount'),
              //                 const Spacer(),
              //                 black16w500(data: '5')
              //               ],
              //             ),*/
              //
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 lightBlack14w400Centre(data: 'Order Total'),
              //                 SizedBox(
              //                   width: 2.w,
              //                 ),
              //                 lightBlack14w400Centre(
              //                     data:
              //                         'AED ${cartViewModel.getCartTotalPrice.toStringAsFixed(2)}'),
              //               ],
              //             ),
              //             if (cartViewModel.getPawSelectedPoints != 0)
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 16).w,
              //                 child: Row(
              //                   children: [
              //                     lightBlack14w400Centre(
              //                         data: 'Loyalty Points Discount'),
              //                     const Spacer(),
              //                     orange14w500(
              //                         data:
              //                             'AED -${cartViewModel.getPawPointDiscount.toStringAsFixed(2)}')
              //                   ],
              //                 ),
              //               ),
              //             if (cartViewModel.getPromoCodeDiscount != 0)
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 16).w,
              //                 child: Row(
              //                   children: [
              //                     lightBlack14w400Centre(
              //                         data:
              //                             'Promo Code Discount${cartViewModel.getPromoCodeResponse.data!.type == 'percentage' ? ' (${cartViewModel.getPromoCodeResponse.data!.discount} %)' : ''}'),
              //                     const Spacer(),
              //                     orange14w500(
              //                         data:
              //                             'AED -${cartViewModel.getPromoCodeDiscount.toStringAsFixed(2)}')
              //                   ],
              //                 ),
              //               ),
              //             SizedBox(
              //               height: 20.h,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 lightBlack14w400Centre(data: 'Subtotal'),
              //                 SizedBox(
              //                   width: 2.w,
              //                 ),
              //                 lightBlack14w400Centre(
              //                     data:
              //                         'AED ${cartViewModel.getSubTotal.toStringAsFixed(2)}'),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 20.h,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 lightBlack14w400Centre(data: 'Delivery Fee'),
              //                 SizedBox(
              //                   width: 2.w,
              //                 ),
              //                 lightBlack14w400Centre(
              //                     data:
              //                         'AED ${cartViewModel.getDeliveryFee.toStringAsFixed(2)} '),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 20.h,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 lightBlack14w400Centre(data: 'VAT'),
              //                 SizedBox(
              //                   width: 2.w,
              //                 ),
              //                 lightBlack14w400Centre(
              //                     data:
              //                         'AED ${cartViewModel.getVat.toStringAsFixed(2)} '),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 20.h,
              //             ),
              //             /* Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 lightBlack14w400Centre(data: 'VAT (5%)'),
              //                 SizedBox(
              //                   width: 2.w,
              //                 ),
              //                 lightBlack14w400Centre(
              //                     data:
              //                     'AED ${cartViewModel.getVatValue.toStringAsFixed(2)}'),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 20.h,
              //             ),*/
              //             Row(
              //               children: [
              //                 lightBlack14w400Centre(data: 'Total'),
              //                 const Spacer(),
              //                 black16w500(
              //                     data:
              //                         'AED ${cartViewModel.getCheckOutTotal.toStringAsFixed(2)}')
              //               ],
              //             ),
              //             SizedBox(
              //               height: 30.h,
              //             ),
              //             customButton(
              //                 text: 'Place Order',
              //                 onPressed: () {
              //                   if (context
              //                           .read<AuthViewModel>()
              //                           .getAuthResponse
              //                           .data!
              //                           .card ==
              //                       null) {
              //                     descriptionDialog(
              //                         context: context,
              //                         description:
              //                             'Kindly Select Payment Method',
              //                         height: 200.h,
              //                         title: 'Alert');
              //                   } else if (context
              //                           .read<AuthViewModel>()
              //                           .getAuthResponse
              //                           .data!
              //                           .location ==
              //                       null) {
              //                     descriptionDialog(
              //                         context: context,
              //                         description: 'Kindly Select Location',
              //                         height: 150.h,
              //                         title: 'Alert');
              //                   } else {
              //                     checkOutConfirmationDialog(context: context);
              //                   }
              //                 },
              //                 colored: true),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }

  Column _buildButtonLabel(CartViewModel cartViewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lightBlack14w400Centre(data: 'Order Total'),
            SizedBox(
              width: 2.w,
            ),
            lightBlack14w400Centre(
                data:
                    'AED ${cartViewModel.getCartTotalPrice.toStringAsFixed(2)}'),
          ],
        ),
        if (cartViewModel.getPawSelectedPoints != 0)
          Padding(
            padding: const EdgeInsets.only(top: 16).w,
            child: Row(
              children: [
                lightBlack14w400Centre(data: 'Loyalty Points Discount'),
                const Spacer(),
                orange14w500(
                    data:
                        'AED -${cartViewModel.getPawPointDiscount.toStringAsFixed(2)}')
              ],
            ),
          ),
        if (cartViewModel.getPromoCodeDiscount != 0)
          Padding(
            padding: const EdgeInsets.only(top: 16).w,
            child: Row(
              children: [
                lightBlack14w400Centre(
                    data:
                        'Promo Code Discount${cartViewModel.getPromoCodeResponse.data!.type == 'percentage' ? ' (${cartViewModel.getPromoCodeResponse.data!.discount} %)' : ''}'),
                const Spacer(),
                orange14w500(
                    data:
                        'AED -${cartViewModel.getPromoCodeDiscount.toStringAsFixed(2)}')
              ],
            ),
          ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lightBlack14w400Centre(data: 'Subtotal'),
            SizedBox(
              width: 2.w,
            ),
            lightBlack14w400Centre(
                data: 'AED ${cartViewModel.getSubTotal.toStringAsFixed(2)}'),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lightBlack14w400Centre(data: 'Delivery Fee'),
            SizedBox(
              width: 2.w,
            ),
            lightBlack14w400Centre(
                data:
                    'AED ${cartViewModel.getDeliveryFee.toStringAsFixed(2)} '),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lightBlack14w400Centre(data: 'VAT'),
            SizedBox(
              width: 2.w,
            ),
            lightBlack14w400Centre(
                data: 'AED ${cartViewModel.getVat.toStringAsFixed(2)} '),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            lightBlack14w400Centre(data: 'VAT (5%)'),
                            SizedBox(
                              width: 2.w,
                            ),
                            lightBlack14w400Centre(
                                data:
                                'AED ${cartViewModel.getVatValue.toStringAsFixed(2)}'),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),*/
        Row(
          children: [
            lightBlack14w400Centre(data: 'Total'),
            const Spacer(),
            black16w500(
                data:
                    'AED ${cartViewModel.getCheckOutTotal.toStringAsFixed(2)}')
          ],
        ),
        if (!context.isBiggerThanMobile)
          SizedBox(
            height: 30.h,
          ),
      ],
    );
  }
}
