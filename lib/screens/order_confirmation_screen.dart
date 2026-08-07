import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/view_models/order_view_model.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:brunos_kitchen/widgets/web_card_widget.dart';
import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});
  onBack() {
    Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        bottomNavigationRoute, (route) => false,
        arguments: {"key": "value"});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(builder: (context, orderViewModel, child) {
      return WillPopScope(
        onWillPop: () async {
          onBack();
          return true;
        },
        child: SafeArea(
          child: CustomScaffold(
            /* appBar:   AppBarWithBackWidget(
              heading: 'Order Confirmation', showPuppy: false,showCart: false, onBackPress: onBack,
            ),*/
            body: Padding(
              padding: const EdgeInsets.only(
                      top: 30, bottom: 30, left: 20, right: 20)
                  .w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          orderConfirmation,
                          width: 104.w,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        black24w500Centre(data: 'Order Confirmed'),
                        SizedBox(
                          height: 20.h,
                        ),
                        Visibility(
                            visible: orderViewModel.getOrderCreateResponse.data!
                                    .pointsEarned! >
                                0,
                            child: orange14w500(
                                align: TextAlign.center,
                                data:
                                    'Congratulations, you have earned ${orderViewModel.getOrderCreateResponse.data!.pointsEarned!.toStringAsFixed(2)} new paw points to your account')),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (context.isBiggerThanMobile)
                    WebSizedBox(
                      child: WebCardWidget(
                        child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: _buildBottom(orderViewModel)),
                      ),
                    )
                  else
                    _buildBottom(orderViewModel),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Column _buildBottom(OrderViewModel orderViewModel) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: CustomColors.whiteColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 0.50, color: CustomColors.greyMediumLightColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lightBlack14w400Centre(data: 'Order detail'),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    grey14w400(data: 'Order number'),
                    SizedBox(
                      width: 2.w,
                    ),
                    lightBlack14w400Centre(
                        data: orderViewModel.getOrderCreateResponse.data!.sId!
                            .substring(orderViewModel
                                    .getOrderCreateResponse.data!.sId!.length -
                                5)),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    grey14w400(data: 'Delivery Date'),
                    SizedBox(
                      width: 2.w,
                    ),
                    lightBlack14w400Centre(
                        data:
                            '${orderViewModel.getOrderCreateResponse.data!.deliveryDate}'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    grey14w400(data: 'Order total'),
                    SizedBox(
                      width: 2.w,
                    ),
                    lightBlack14w400Centre(
                        data:
                            'AED ${orderViewModel.getOrderCreateResponse.data!.cartTotal!.toStringAsFixed(2)}'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Visibility(
                  visible:
                      orderViewModel.getOrderCreateResponse.data!.discount != 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          grey14w400(data: 'Discount'),
                          SizedBox(
                            width: 2.w,
                          ),
                          lightBlack14w400Centre(
                              data:
                                  'AED ${orderViewModel.getOrderCreateResponse.data!.discount!.toStringAsFixed(2)}'),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    grey14w400(data: 'Shipping Fee'),
                    SizedBox(
                      width: 2.w,
                    ),
                    lightBlack14w400Centre(
                        data:
                            'AED ${orderViewModel.getOrderCreateResponse.data!.shippingFees!.toStringAsFixed(2)}'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    grey14w400(data: 'VAT'),
                    SizedBox(
                      width: 2.w,
                    ),
                    lightBlack14w400Centre(
                        data:
                            'AED ${orderViewModel.getOrderCreateResponse.data!.vat!.toStringAsFixed(2)}'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    grey14w400(data: 'Amount paid'),
                    SizedBox(
                      width: 2.w,
                    ),
                    lightBlack14w400Centre(
                        data:
                            'AED ${orderViewModel.getOrderCreateResponse.data!.totalAmount!.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        customButton(
            text: 'Continue',
            onPressed: () {
              onBack();
            },
            colored: true),
      ],
    );
  }
}
