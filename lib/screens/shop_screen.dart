import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/widgets/cart_icon_widget.dart';
import 'package:brunos_kitchen/widgets/gridChip/product_grid_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/images.dart';
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
          body: _buildBody(context, plansViewModel),
        ),
      );
    });
  }

  Widget _buildBody(BuildContext context, PlansViewModel plansViewModel) {
    final data = plansViewModel.getRecipesListResponse.data;
    return Padding(
      padding: const EdgeInsets.all(20).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            spacing: 10.w,
            children: [
              black24w500Centre(data: 'Shop'),
              Spacer(),
              SizedBox(
                height: context.isBiggerThanMobile ? 60.h : 30.h,
                width: context.isBiggerThanMobile ? 60.h : 30.h,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, profileRoute);
                  },
                  child: CircleAvatar(
                    backgroundColor: CustomColors.purpleColorTint,
                    child: Center(
                      child: Icon(
                        Icons.person_outline,
                        size: 15.sp,
                        color: CustomColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              cartIconWidget()
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          if (context.isBiggerThanMobile)
            Center(
              child: Container(
                width: MediaQuery.widthOf(context) * 0.35,
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                child: InkWell(
                  onTap: () {
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
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(40.r),
                    child: Image.asset(dogBannerMonthly),
                  ),
                ),
              ),
            )
          else
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
          if (data != null)
            Expanded(child: _buildCustomPlanData(context, plansViewModel)),
        ],
      ),
    );
  }

  Widget _buildCustomPlanData(
    BuildContext context,
    PlansViewModel plansViewModel,
  ) {
    return Padding(
      padding: context.isBiggerThanMobile
          ? EdgeInsets.symmetric(horizontal: 0.03.sw)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(child: grey14w400HeightCentre(data: 'OR')),
          if (context.isBiggerThanMobile)
            Expanded(
              child: Row(
                spacing: 20.w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      black18w500(data: 'Select Category'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: Container(
                          width: 430.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.greyColor,
                            ),
                            borderRadius: BorderRadiusGeometry.circular(15.r),
                          ),
                          padding: EdgeInsets.all(20.w),
                          child: Wrap(
                            runSpacing: 10.h,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                                plansViewModel.getRecipesListResponse.data!
                                    .categories!.length, (index) {
                              final data = plansViewModel.getRecipesListResponse
                                  .data!.categories![index];
                              return Container(
                                margin:
                                    const EdgeInsets.only(right: 20, left: 20)
                                        .w,
                                width:
                                    context.isBiggerThanMobile ? 150.w : 140.w,
                                child: customSquareButton(
                                    text: data.name!,
                                    onPressed: () {
                                      plansViewModel
                                          .setProductCategory(data.name!);
                                    },
                                    colored:
                                        plansViewModel.getProductCategory ==
                                            data.name),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  recipeData:
                                      plansViewModel.getProductList[index],
                                  showInformationIcon: false,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else ...{
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: plansViewModel
                    .getRecipesListResponse.data!.categories!
                    .map(
                      (data) => Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: context.isBiggerThanMobile ? 150.w : 140.w,
                        child: customSquareButton(
                            text: data.name!,
                            onPressed: () {
                              plansViewModel.setProductCategory(data.name!);
                            },
                            colored:
                                plansViewModel.getProductCategory == data.name),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      runSpacing: 20.w,
                      spacing: 20.w,
                      alignment: plansViewModel.getProductList.length == 1
                          ? WrapAlignment.start
                          : WrapAlignment.center,
                      children: List.generate(
                          plansViewModel.getProductList.length, (index) {
                        return SizedBox(
                          width: 157.w,
                          child: productGridChipWidget(
                              recipeData: plansViewModel.getProductList[index],
                              showInformationIcon: false),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 80.h,
                    )
                  ],
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}
