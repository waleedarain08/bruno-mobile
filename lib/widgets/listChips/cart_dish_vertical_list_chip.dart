import 'package:brunos_kitchen/models/recipe_model.dart';
import 'package:brunos_kitchen/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../circular_network_image_widget.dart';

Widget cartDishVerticalListChipWidget(
    {required RecipeModel cartRecipeModel,
    required String planType,
    String? petName,
    required num totalWeight}) {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: ShapeDecoration(
        color: CustomColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15).w,
        child: Row(
          children: [
            circularNetworkImageWidget(
                image: cartRecipeModel.media![0], size: 40.h),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 210.w,
                      child: black14w500(data: cartRecipeModel.name!)),
                  const SizedBox(
                    height: 2,
                  ),
                  cartRecipeModel.sizes!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 2.0).w,
                          child: black14w500(
                              data: ''
                                  'Option: ${cartRecipeModel.selectedItemSize!.name!}'),
                        )
                      : const SizedBox(),
                  planType == Plans.monthly.text
                      ? black14w500(data: 'Days: ${cartRecipeModel.totalDays}')
                      : planType == Plans.transitional.text
                          ? const SizedBox()
                          :
                          //TODO: REMOVE ONETIME ORDER
                          /*planType == Plans.oneTime.text
                      ? black14w500(
                      data: 'Quantity: ${cartRecipeModel.totalDays}'):*/
                          black14w500(
                              data: 'Quantity: ${cartRecipeModel.quantity}'),
                  /* Visibility(
                    visible: planType != Plans.transitional.text,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: grey14w400(data: 'AED ${(cartRecipeModel
                          .finalPrice!/cartRecipeModel.totalDays!/cartRecipeModel.quantity!).round()} / ${planType == Plans.monthly.text? 'Day': 'Item'}'),
                    ),
                  ),*/
                  const SizedBox(
                    height: 2,
                  ),
                  //TODO: REMOVE ONETIME ORDER

                  /*petName != null ? orange14w500(
                      data: 'AED ${cartRecipeModel
                          .finalPrice}${planType == Plans.oneTime.text?'':' / Order'}'):*/
                  planType == Plans.product.text
                      ? orange14w500(
                          data:
                              'AED ${cartRecipeModel.pricePerKG!.toStringAsFixed(2)} / Item')
                      : orange14w500(data: '$totalWeight Grams/Plan'),
                  const SizedBox(
                    height: 2,
                  ),
                  planType == Plans.monthly.text
                      ? orange14w500(
                          data:
                              'Sub Total: AED ${cartRecipeModel.finalPrice!.toStringAsFixed(2)}')
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
