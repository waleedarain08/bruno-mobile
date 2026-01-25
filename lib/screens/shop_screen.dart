import 'package:brunos_kitchen/widgets/cart_icon_widget.dart';
import 'package:brunos_kitchen/widgets/gridChip/product_grid_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/navigations_validation.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/plans_view_model.dart';
import '../view_models/puppy_view_model.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansViewModel>(builder: (context, plansViewModel, child) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [black24w500Centre(data: 'Shop'), cartIconWidget()],
                ),
                SizedBox(
                  height: 20.h,
                ),
                customButton(
                    text: '<< Monthly Plan >>',
                    /* boldText: 'Tap Here',*/
                    onPressed: () {
                      if (context
                              .read<AuthViewModel>()
                              .getAuthResponse
                              .data!
                              .petsCount ==
                          0) {
                        context
                            .read<PuppyViewModel>()
                            .setRouteToPuppyFrom(Screens.shop.text);
                        context.read<PuppyViewModel>().clearPuppyData();
                        Navigator.pushNamed(context, puppyCreationRoute);
                      } else {
                        navigateToMonthlyPlans(context: context);
                      }
                      /*   SendGridPref sendGrid = SendGridPref();
                      sendGrid.sendEmail(emailSubject: 'Registration', emailDescription: 'Register Successfully');
                      */
                    },
                    colored: true),
                SizedBox(
                  height: 20.h,
                ),
                Center(child: grey14w400HeightCentre(data: 'OR')),

                black18w500(data: 'Select Category'),
                SizedBox(
                  height: 20.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: plansViewModel
                        .getRecipesListResponse.data!.categories!
                        .map(
                          (data) => Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 140.w,
                            child: customSquareButton(
                                text: data.name!,
                                onPressed: () {
                                  plansViewModel.setProductCategory(data.name!);
                                },
                                colored: plansViewModel.getProductCategory ==
                                    data.name),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                black18w500(data: 'Products'),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: MasonryGridView.extent(
                    maxCrossAxisExtent: 157.w,
                    itemCount: plansViewModel.getProductList.length,
                    padding: EdgeInsets.only(bottom: 80.h),
                    primary: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 157.w,
                        child: productGridChipWidget(
                          recipeData: plansViewModel.getProductList[index],
                          showInformationIcon: false,
                        ),
                      );
                    },
                  ),
                ),

                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         Wrap(
                //           runSpacing: 20.w,
                //           spacing: 20.w,
                //           alignment: plansViewModel.getProductList.length == 1
                //               ? WrapAlignment.start
                //               : WrapAlignment.center,
                //           children: List.generate(plansViewModel.getProductList.length,
                //               (index) {
                //             return SizedBox(
                //               width: 157.w,
                //               child: productGridChipWidget(
                //                   recipeData: plansViewModel.getProductList[index], showInformationIcon: false),
                //             );
                //           }),
                //         ),
                //         SizedBox(height: 80.h,)
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
