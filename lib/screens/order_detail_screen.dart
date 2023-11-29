import 'package:brunos_kitchen/models/cart_model.dart';
import 'package:brunos_kitchen/view_models/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/order_model.dart';
import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../view_models/cart_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/listChips/cart_vertical_list_chip_widget.dart';
import '../widgets/listChips/order_items_vertical_list_chip_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(builder: (context, orderViewModel, child) {
      return Scaffold(
        appBar: const AppBarWithBackWidget(
            heading: 'Order Detail', showPuppy: false, showCart: false),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: CustomColors.orangeColorTint,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.50, color: CustomColors.greyMediumLightColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          grey14w400(data: 'Order number'),
                          SizedBox(
                            width: 2.w,
                          ),
                          lightBlack14w400Centre(
                              data: orderViewModel.getSelectedOrder.sId!
                                  .substring(orderViewModel
                                          .getSelectedOrder.sId!.length -
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
                                  '${orderViewModel.getSelectedOrder.deliveryDate}'),
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
                                  'AED ${orderViewModel.getSelectedOrder.cartTotal}'),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
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
                                  'AED ${orderViewModel.getSelectedOrder.shippingFees}'),
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
                                  'AED ${orderViewModel.getSelectedOrder.totalAmount}'),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      customButton(
                          height: 40.h,
                          text: 'Re-order',
                          onPressed: () {
                            context.read<CartViewModel>().getCartList.clear();
                            for (int i = 0;
                                i <
                                    orderViewModel
                                        .getSelectedOrder.orderItems!.length;
                                i++) {
                              final CartModel orderSingleItemData = orderViewModel.setToCartModel(index: i);
                              context.read<CartViewModel>().addToCartList(orderSingleItemData);
                            }
                            Navigator.pushNamed(navigatorKey.currentContext!, cartRoute);
                          },
                          colored: true)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderViewModel.getSelectedOrder.orderItems!.length,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                itemBuilder: (BuildContext context, int index) {
                  return orderItemsVerticalListChipWidget(
                      itemIndex: index,
                      orderItems:
                          orderViewModel.getSelectedOrder.orderItems![index],
                      showButtons: false);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
