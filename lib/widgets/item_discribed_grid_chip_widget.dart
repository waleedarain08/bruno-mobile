
import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:brunos_kitchen/widgets/circular_network_image_widget.dart';
import 'package:brunos_kitchen/widgets/recipe_detail_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/recipe_model.dart';
import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../utils/recipes_calculation.dart';
import 'one_time_order_bottom_sheet_widget.dart';

Widget itemDescribedGridChipWidget({required RecipeModel recipeModel}) {
  return Consumer<PlansViewModel>(builder: (context, plansViewModel, child)
  {
    return InkWell(
      onTap: () {
        plansViewModel.setSelectedRecipe(
            recipeModel);
        if (plansViewModel.getPlanType ==
            Plans.oneTime.text) {
          oneTimeOrderBottomSheetWidget();
        }
        else if(plansViewModel.getPlanType ==
            Plans.product.text){
          Navigator.pushNamed(
              navigatorKey.currentContext!, shopItemDetailRoute);
        }
        else {
          Navigator.pushNamed(
              navigatorKey.currentContext!, deliveryDatesRoute);
        }
      },
      child: Card(
          elevation: 2,
          color: CustomColors.whiteColor,
          borderOnForeground: false,
          shape: const RoundedRectangleBorder(
            // side: BorderSide(color: CustomColors.whiteColor),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: CustomColors.lightGreyColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Image.network(
                            recipeModel.media!, height: 108.h,
                          ),
                        ),
                        Visibility(
                          visible: plansViewModel.getPlanType !=
                              Plans.product.text,
                          child: InkWell(
                            onTap: () {
                              recipeDetailBottomSheetWidget(
                                  recipeDetail: recipeModel);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(informationButton),),
                            ),
                          ),
                        )
                        /*IconButton(
                            onPressed: () {
                              recipeDetailBottomSheetWidget();
                            },
                            icon: Icon(
                              Icons.info,
                              color: CustomColors.orangeColorTint,
                            ),
                          ))*/
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 17.0, right: 17, top: 7, bottom: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 40.h,
                          child: lightBlack14w400Centre(
                              data: recipeModel.name!, left: true)),
                      Visibility(
                        visible: recipeModel.ingredientsComposition!.isNotEmpty,
                        child: black10w400(
                            maxLine: 2,
                            data: recipeModel.ingredientsComposition!),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      brown12w500Centre(
                          data: 'AED ${recipeModel.pricePerKG} / KG'),
                      SizedBox(
                        height: 2.h,
                      ),
                      black10w400(data: 'complete trans period'),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  });
}
