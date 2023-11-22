import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';

Future redeemPawPointsBottomSheetWidget() {
  return showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: CustomColors.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: navigatorKey.currentContext!,
      builder: (context) {
  return Consumer<CartViewModel>(builder: (context, cartViewModel, child)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  black18w500(data: 'Redeem PawPoints'),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: CustomColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.75,
                              color: CustomColors.greyMediumColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.clear,
                          size: 20,
                          color: CustomColors.greyColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              lightBlack14w400Centre(
                  data:
                  'you can use your loyalty points  to get discount, by converting your loyalty points to % discount coupon',
                  left: true),
              SizedBox(
                height: 30.h,
              ),
              SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: CustomColors.orangeColor,
                    inactiveTrackColor: CustomColors.greyColor,
                    trackShape: SliderCustomTrackShape(),
                    trackHeight: 15.0,
                    thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 12.0),
                    thumbColor: CustomColors.whiteColor,
                    overlayShape: SliderComponentShape.noOverlay,
                    tickMarkShape: const RoundSliderTickMarkShape(),
                    //  activeTickMarkColor: CustomColors.orangeColor,
                    //  inactiveTickMarkColor: Colors.grey.shade200,
                    valueIndicatorShape:
                    const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: CustomColors.orangeColor,
                    valueIndicatorTextStyle: const TextStyle(
                      color: CustomColors.blackColor,
                    ),
                  ),
                  child: Slider(
                    value: cartViewModel
                        .getPawPoints,
                    min: 0,
                    //divisions: 1,
                    label: cartViewModel
                        .getPawPoints
                        .toString(),
                    max: cartViewModel.getCartTotalPrice >= context
                        .read<AuthViewModel>()
                        .getAuthResponse
                        .data!
                        .availablePoints!? context
                        .watch<AuthViewModel>()
                        .getAuthResponse
                        .data!
                        .availablePoints!.toDouble() : cartViewModel.getCartTotalPrice.toDouble(),
                    onChanged: (double value) {
                      cartViewModel.setPawPoints(value);
                    },
                  )),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  lightBlack14w400Centre(data: '0'),
                  lightBlack14w400Centre(data: '${
                      cartViewModel.getCartTotalPrice >= context
                          .read<AuthViewModel>()
                          .getAuthResponse
                          .data!
                          .availablePoints!? context
                          .watch<AuthViewModel>()
                          .getAuthResponse
                          .data!
                          .availablePoints!.toDouble() : cartViewModel.getCartTotalPrice.toDouble()
                  } Points'),
                ],
              ),
               SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lightBlack14w400Centre(data: 'Selected Paw Points'),
                      lightBlack14w400Centre(data: cartViewModel
                          .getPawPoints.round()
                          .toString()),
                    ],
                  ),
                  /*SizedBox(
                    height: 10.h,
                  ),
                  Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          lightBlack14w400Centre(data: 'ME432DW'),
                          brown12w500Centre(data: 'Copy'),
                        ],
                      ),
                    ),
                  ),*/
              SizedBox(height: 50.h,),
              customButton(
                  text: 'Use Paw Points',
                  onPressed: () {
                    cartViewModel.setPawSelectedPoints();
                    Navigator.pop(context);
                  },
                  colored: true),
            ],
          ),
        ],
      ),
    );
  });      });
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}