import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/order_model.dart';
import '../../route_generator.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/enums.dart';
import '../../utils/images.dart';
import '../../view_models/cart_view_model.dart';
import '../../view_models/plans_view_model.dart';
import '../circular_network_image_widget.dart';
import 'cart_dish_vertical_list_chip.dart';

Widget orderItemsVerticalListChipWidget(
    {required OrderItems orderItems,
    required int itemIndex,
    required bool showButtons}) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          navigatorKey.currentContext!
              .read<CartViewModel>()
              .setViewCartItemDetail(true);
          navigatorKey.currentContext!
              .read<PlansViewModel>()
              .setDataToFeedingPlan(data: orderItems);
          if (orderItems.planType == Plans.product) {
            Navigator.pushNamed(
                navigatorKey.currentContext!, productDetailRoute);
          } else {
            Navigator.pushNamed(navigatorKey.currentContext!, feedingPlanRoute);
          }
        },
        child: Container(
          decoration: ShapeDecoration(
            color: CustomColors.lightGreyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    orange18w500(
                        data:
                            '${orderItems.planType} ${orderItems.pet == null ? '' : 'Plan'}'),
                    Container(
                      decoration: ShapeDecoration(
                        color: CustomColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.75, color: CustomColors.greyMediumColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10).w,
                        child: const Icon(
                          Icons.sticky_note_2_outlined,
                          size: 20,
                          color: CustomColors.orangeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                orderItems.pet != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              orderItems.pet!.media!.isNotEmpty
                                  ? circularNetworkImageWidget(
                                      image: orderItems.pet!.media!, size: 40.h)
                                  : SizedBox(
                                      height: 40.h,
                                      width: 40.h,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            CustomColors.yellowColor,
                                        child: SvgPicture.asset(dogFace),
                                      ),
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  black14w500(data: orderItems.pet!.name!),
                                  black14w500(data: orderItems.pet!.breed!),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 20.h,
                ),
                Visibility(
                  visible: showButtons,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20).w,
                    child: Row(
                      children: [
                        Expanded(
                            child: customButton(
                                height: 40.h,
                                text: 'Freeze',
                                onPressed: () {
                                  EasyLoading.showSuccess(
                                      'Status Updated to Admin');
                                },
                                colored: true)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: customButton(
                                height: 40.h,
                                text: 'Cancel',
                                onPressed: () {
                                  EasyLoading.showSuccess(
                                      'Status Updated to Admin');
                                },
                                colored: true))
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderItems.recipes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cartDishVerticalListChipWidget(
                        cartRecipeModel: orderItems.recipes![index],
                        totalWeight: orderItems.totalWeight!.isNotEmpty
                            ? orderItems.totalWeight![index]
                            : 0,
                        planType: orderItems.planType!,
                        petName: orderItems.pet != null
                            ? orderItems.pet!.name!
                            : '');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: black14w500(
                        data:
                            'Total: AED ${orderItems.planDiscountedPrice!.toStringAsFixed(2)}'))
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
    ],
  );
}
