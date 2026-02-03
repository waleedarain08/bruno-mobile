import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:brunos_kitchen/widgets/bottomSheet/recipe_detail_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/recipe_model.dart';
import '../../utils/custom_colors.dart';
import '../../utils/enums.dart';
import '../../view_models/cart_view_model.dart';

Widget productGridChipWidget(
    {required RecipeModel recipeData, required bool showInformationIcon}) {
  return Consumer<PlansViewModel>(builder: (context, plansViewModel, child) {
    return InkWell(
      onTap: () {
        if (plansViewModel.getPlanType == Plans.monthly.text) {
          plansViewModel.setPlanType(Plans.product.text);
        }
        plansViewModel.setSelectedRecipe(recipeData);
        //TODO: REMOVE ONETIME ORDER
        context.read<CartViewModel>().setViewCartItemDetail(false);
        navigatorKey.currentContext!.read<PlansViewModel>().clearPlanData();
        Navigator.pushNamed(navigatorKey.currentContext!, productDetailRoute);
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
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                height: 108.h,
                                width: 70.w,
                                child: Center(
                                  child: LinearProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: showInformationIcon,
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
                      Visibility(
                        visible: recipeData.lifeStage!.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0).h,
                          child:
                              black14w500(data: '(${recipeData.lifeStage!})'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  });
}
