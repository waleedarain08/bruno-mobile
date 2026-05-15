import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/cart_model.dart';
import '../../utils/custom_colors.dart';
import '../../utils/enums.dart';
import '../../utils/images.dart';
import '../circular_network_image_widget.dart';
import 'cart_dish_vertical_list_chip.dart';

Widget cartVerticalListChipWidget(
    {required CartModel cartDetail, required int itemIndex}) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          navigatorKey.currentContext!
              .read<CartViewModel>()
              .setViewCartItemDetail(true);
          navigatorKey.currentContext!
              .read<PlansViewModel>()
              .setDataToFeedingPlan(data: cartDetail);
          if (cartDetail.planType == Plans.product) {
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: orange18w500(
                          data:
                              '${cartDetail.planType.text} ${cartDetail.pet == null ? '' : 'Plan'}'),
                    ),
                    InkWell(
                      onTap: () {
                        navigatorKey.currentContext!
                            .read<CartViewModel>()
                            .setViewCartItemDetail(false);
                        navigatorKey.currentContext!
                            .read<CartViewModel>()
                            .setSelectedIndex(itemIndex);
                        navigatorKey.currentContext!
                            .read<PlansViewModel>()
                            .setDataToFeedingPlan(data: cartDetail);
                        cartDetail.planType == Plans.monthly
                            ? {
                                Navigator.pushNamed(
                                    navigatorKey.currentContext!,
                                    monthlyPlanRoute)
                              }
                            : cartDetail.planType == Plans.transitional
                                ? Navigator.pushNamed(
                                    navigatorKey.currentContext!,
                                    transitionPlanRoute)
                                :
                                //TODO: REMOVE ONETIME ORDER
                                /*cartDetail.planType == Plans.oneTime.text
                                    ? Navigator.pushNamed(
                                        navigatorKey.currentContext!,
                                        oneTimePlanRoute)
                                    :*/
                                Navigator.pushNamed(
                                    navigatorKey.currentContext!,
                                    productDetailRoute);
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
                        child: Padding(
                          padding: const EdgeInsets.all(10).w,
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: CustomColors.orangeColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        navigatorKey.currentContext!
                            .read<CartViewModel>()
                            .removeFromCartList(cartDetail);
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
                        child: Padding(
                          padding: const EdgeInsets.all(10).w,
                          child: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: CustomColors.orangeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                cartDetail.pet != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              cartDetail.pet!.media!.isNotEmpty
                                  ? circularNetworkImageWidget(
                                      image: cartDetail.pet!.media!, size: 40.h)
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
                                  black14w500(data: cartDetail.pet!.name!),
                                  black14w500(data: cartDetail.pet!.breed!),
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
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartDetail.recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cartDishVerticalListChipWidget(
                        cartRecipeModel: cartDetail.recipes[index],
                        planType: cartDetail.planType,
                        petName: cartDetail.pet?.name!,
                        totalWeight: cartDetail.totalWeight.isNotEmpty
                            ? cartDetail.totalWeight[index]
                            : 0);
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
                            'Payable: AED ${cartDetail.planType == Plans.monthly ? cartDetail.planDiscountedPrice.toStringAsFixed(2) : cartDetail.planTotal.toStringAsFixed(2)}'))
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
