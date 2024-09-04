
import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:brunos_kitchen/widgets/circular_network_image_widget.dart';
import 'package:brunos_kitchen/widgets/bottomSheet/recipe_detail_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/recipe_model.dart';
import '../../utils/custom_colors.dart';
import '../../utils/enums.dart';
import '../../utils/calculations.dart';
import '../../view_models/cart_view_model.dart';
import '../bottomSheet/one_time_order_bottom_sheet_widget.dart';

Widget itemDescribedGridChipWidget({required RecipeModel recipeData , required bool showInformationIcon}) {
  return Consumer<PlansViewModel>(builder: (context, plansViewModel, child)
  {
    return InkWell(
      onTap: () {
        plansViewModel.setSelectedRecipe(
            recipeData);
        //TODO: REMOVE ONETIME ORDER
        /*if (plansViewModel.getPlanType ==
            Plans.oneTime.text) {
          oneTimeOrderBottomSheetWidget(data: recipeData);
        }
        else*/ if(plansViewModel.getPlanType ==
            Plans.product.text){
          context.read<CartViewModel>().setViewCartItemDetail(false);
          navigatorKey.currentContext!.read<PlansViewModel>().clearPlanData();
          Navigator.pushNamed(
              navigatorKey.currentContext!, productDetailRoute);
        }
        else {
          context.read<CartViewModel>().setViewCartItemDetail(false);
          Navigator.pushNamed(
              navigatorKey.currentContext!, feedingPlanRoute);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                              recipeData.media![0],
                              height: 108.h,
                            )),
                        Visibility(
                          visible: showInformationIcon ,
                          child: InkWell(
                            onTap: () {
                              //TODO: CHANGE RECIPE MODEL
                              recipeDetailBottomSheetWidget(
                                  recipeDetail: recipeData);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: SvgPicture.asset(informationButton)),
                            ),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      black14w500(data: recipeData.name!, centre: true),
                      SizedBox(
                        height: 5.h,
                      ),
                      black14w500(data: '(${recipeData.lifeStage!})'),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  });
}
