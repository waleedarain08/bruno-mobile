import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../route_generator.dart';
import '../utils/calculations.dart';
import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../utils/widget_utils.dart';
import '../view_models/cart_view_model.dart';
import '../view_models/plans_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/circular_network_image_widget.dart';
import '../widgets/labeled_bottom_button.dart';

class FeedingPlanScreen extends StatefulWidget {
  const FeedingPlanScreen({super.key});

  @override
  State<FeedingPlanScreen> createState() => _FeedingPlanScreenState();
}

class _FeedingPlanScreenState extends State<FeedingPlanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final authProvider = context.read<AuthViewModel>();
        if (authProvider.getAuthResponse.data?.pet == null) {
          return;
        }
        context.read<PlansViewModel>().setFeedingPlan(
              petData: context.read<AuthViewModel>().getAuthResponse.data!.pet!,
              planDiscountPer: context.read<PlansViewModel>().getPlanType ==
                      Plans.monthly.text
                  ? context
                      .read<AuthViewModel>()
                      .getAuthResponse
                      .data!
                      .discounts![3]
                      .aggregate!
                  : 0,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansViewModel>(
      builder: (context, plansViewModel, child) {
        return SafeArea(
          child: CustomScaffold(
            appBar: AppBarWithBackWidget(
                heading: plansViewModel.getPlanType == Plans.transitional.text
                    ? 'Transitional Feeding Plan'
                    : plansViewModel.getPlanType == Plans.monthly.text
                        ? 'Monthly Feeding Plan'
                        : 'One time Feeding Order',
                showPuppy: false,
                showCart: !context.read<CartViewModel>().getViewCartItemDetail),
            body: _buildBody(context, plansViewModel),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, PlansViewModel plansViewModel) {
    if (context.isBiggerThanMobile) {
      return Row(
        children: [
          Expanded(
            child: _buildFeedingPlan(plansViewModel),
          ),
          Expanded(child: Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 30.h, right: 20.w),
            child: LabeledBottomButton(
              label: Column(
                children: [
                  Visibility(
                    visible: plansViewModel.getPlanType == Plans.monthly.text &&
                        context
                            .watch<AuthViewModel>()
                            .getAuthResponse
                            .data!
                            .discounts![3]
                            .aggregate !=
                            0,
                    child: Column(
                      children: [
                        orange14w500(
                            data:
                            'Total Price = ${plansViewModel.getFeedingPlan!.planTotal} AED'),
                        SizedBox(
                          height: 5.h,
                        ),
                        orange14w500(
                            data:
                            'Discount = ${context.watch<AuthViewModel>().getAuthResponse.data!.discounts![3].aggregate} %'),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  orange14w500(
                      data:
                      'Total ${plansViewModel.getPlanType} Plan = ${plansViewModel.getPlanType == Plans.monthly.text ? plansViewModel.getFeedingPlan!.planDiscountedPrice.toStringAsFixed(2) : plansViewModel.getFeedingPlan!.planTotal.toStringAsFixed(2)} AED'),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                      width: context.isBiggerThanMobile ? null : 250.w,
                      child: black12w500Centre(
                          data:
                          'The above plan is calculated based on \n${plansViewModel.getFeedingPlan!.pet!.name!}\'s profile data',
                          centre: true)),
                ],
              ),
              isButtonVisible:
              context.read<CartViewModel>().getViewCartItemDetail == false,
              buttonText: 'Add to Shopping Cart',
              onTap: () {
                if (!context.read<CartViewModel>().getViewCartItemDetail) {
                  context.read<CartViewModel>().addToCartList(
                    CartModel(
                        recipes: plansViewModel.getFeedingPlan!.recipes,
                        pet: plansViewModel.getFeedingPlan!.pet,
                        /*
                                          deliveryDate: deliveryDate,
                                */
                        planType: plansViewModel.getFeedingPlan!.planType,
                        planTotal: plansViewModel.getFeedingPlan!.planTotal,
                        pouchesDetail:
                        plansViewModel.getFeedingPlan!.pouchesDetail,
                        totalWeight:
                        plansViewModel.getFeedingPlan!.totalWeight,
                        planDiscountedPrice: plansViewModel
                            .getFeedingPlan!.planDiscountedPrice,
                        planDiscountPer:
                        plansViewModel.getFeedingPlan!.planDiscountPer),
                  );
                  if (context.read<CartViewModel>().getSelectedIndex == null) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, bottomNavigationRoute, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, cartRoute, (Route route) => route.isFirst);
                  }

                  /*EasyLoading.showToast(
                                            '${plansViewModel.getPlanType} Plan Successfully Added To\nShopping Bag',
                                            toastPosition:
                                                EasyLoadingToastPosition.center);*/
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),),
        ],
      );
    }
    return Stack(
      children: [
        if (plansViewModel.getFeedingPlan != null)
          _buildFeedingPlan(plansViewModel),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: LabeledBottomButton(
            label: Column(
              children: [
                Visibility(
                  visible: plansViewModel.getPlanType == Plans.monthly.text &&
                      context
                              .watch<AuthViewModel>()
                              .getAuthResponse
                              .data!
                              .discounts![3]
                              .aggregate !=
                          0,
                  child: Column(
                    children: [
                      orange14w500(
                          data:
                              'Total Price = ${plansViewModel.getFeedingPlan!.planTotal} AED'),
                      SizedBox(
                        height: 5.h,
                      ),
                      orange14w500(
                          data:
                              'Discount = ${context.watch<AuthViewModel>().getAuthResponse.data!.discounts![3].aggregate} %'),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                orange14w500(
                    data:
                        'Total ${plansViewModel.getPlanType} Plan = ${plansViewModel.getPlanType == Plans.monthly.text ? plansViewModel.getFeedingPlan!.planDiscountedPrice.toStringAsFixed(2) : plansViewModel.getFeedingPlan!.planTotal.toStringAsFixed(2)} AED'),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    width: context.isBiggerThanMobile ? null : 250.w,
                    child: black12w500Centre(
                        data:
                            'The above plan is calculated based on \n${plansViewModel.getFeedingPlan!.pet!.name!}\'s profile data',
                        centre: true)),
              ],
            ),
            isButtonVisible:
                context.read<CartViewModel>().getViewCartItemDetail == false,
            buttonText: 'Add to Shopping Cart',
            onTap: () {
              if (!context.read<CartViewModel>().getViewCartItemDetail) {
                context.read<CartViewModel>().addToCartList(
                      CartModel(
                          recipes: plansViewModel.getFeedingPlan!.recipes,
                          pet: plansViewModel.getFeedingPlan!.pet,
                          /*
                                        deliveryDate: deliveryDate,
                              */
                          planType: plansViewModel.getFeedingPlan!.planType,
                          planTotal: plansViewModel.getFeedingPlan!.planTotal,
                          pouchesDetail:
                              plansViewModel.getFeedingPlan!.pouchesDetail,
                          totalWeight:
                              plansViewModel.getFeedingPlan!.totalWeight,
                          planDiscountedPrice: plansViewModel
                              .getFeedingPlan!.planDiscountedPrice,
                          planDiscountPer:
                              plansViewModel.getFeedingPlan!.planDiscountPer),
                    );
                if (context.read<CartViewModel>().getSelectedIndex == null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, bottomNavigationRoute, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, cartRoute, (Route route) => route.isFirst);
                }

                /*EasyLoading.showToast(
                                          '${plansViewModel.getPlanType} Plan Successfully Added To\nShopping Bag',
                                          toastPosition:
                                              EasyLoadingToastPosition.center);*/
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }

  Center _buildFeedingPlan(PlansViewModel plansViewModel) {
    return Center(
      child: SizedBox(
        width: context.isBiggerThanMobile
            ? MediaQuery.widthOf(context) * 0.5
            : null,
        child: ListView.separated(
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: plansViewModel.getFeedingPlan!.recipes.length,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 280)
                  .w,
          itemBuilder: (BuildContext context, int index) {
            final num totalPlanQuantity = calculateDailyIntake(
                    recipeModel: plansViewModel.getFeedingPlan!.recipes[index],
                    puppyActivityLevel:
                        plansViewModel.getFeedingPlan!.pet!.activityLevel!,
                    currentWeight:
                        plansViewModel.getFeedingPlan!.pet!.currentWeight!,
                    puppyActualWeight:
                        plansViewModel.getFeedingPlan!.pet!.actualWeight!) *
                (plansViewModel.getFeedingPlan!.recipes[index].totalDays!);
            final num perPouchQuantity = calculateFeedingPlan(
                recipeModel: plansViewModel.getFeedingPlan!.recipes[index],
                puppyModel: plansViewModel.getFeedingPlan!.pet!);
            final num transitionalPlanTotalQuantity =
                plansViewModel.getTotalTransitionalGrams();
            /* final num transitional1to3PerPouchQty =
                    calculateFeedingPlan(
                        recipeModel:
                        plansViewModel.getFeedingPlan!.recipes[index],
                        puppyModel: plansViewModel.getFeedingPlan!.pet!,
                        gramsForTransitional:
                        plansViewModel.getTransitionalGrams1to3Days);
                    final num transitional4to6PerPouchQty =
                    calculateFeedingPlan(
                        recipeModel:
                        plansViewModel.getFeedingPlan!.recipes[index],
                        puppyModel: plansViewModel.getFeedingPlan!.pet!,
                        gramsForTransitional:
                        plansViewModel.getTransitionalGrams4to6Days);
                    final num transitional7to9PerPouchQty =
                    calculateFeedingPlan(
                        recipeModel:
                        plansViewModel.getFeedingPlan!.recipes[index],
                        puppyModel: plansViewModel.getFeedingPlan!.pet!,
                        gramsForTransitional:
                        plansViewModel.getTransitionalGrams7to9Days);
                    final num transitional10thPerPouchQty =
                    calculateFeedingPlan(
                        recipeModel:
                        plansViewModel.getFeedingPlan!.recipes[index],
                        puppyModel: plansViewModel.getFeedingPlan!.pet!,
                        gramsForTransitional:
                        plansViewModel.getTransitionalGrams10thDay);*/
            return ListTile(
              minVerticalPadding: 20.w,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0).w,
                child: Row(
                  children: [
                    circularNetworkImageWidget(
                        image: plansViewModel
                            .getFeedingPlan!.recipes[index].media![0],
                        size: 40.h),
                    SizedBox(
                      width: 10.w,
                    ),
                    orange18w500(
                        data: plansViewModel
                            .getFeedingPlan!.recipes[index].name!),
                  ],
                ),
              ),
              tileColor: CustomColors.lightGreyColor,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 230.w,
                      child: black12w500Centre(
                          data:
                              'Recommended total feeding amount for ${plansViewModel.getFeedingPlan!.pet!.name!} is:')),
                  Align(
                    alignment: Alignment.centerRight,
                    child: orange14w500(
                        data:
                            '${plansViewModel.getPlanType == Plans.transitional.text ? transitionalPlanTotalQuantity : totalPlanQuantity} Grams/Plan'),
                  ),
                  black14w500(data: 'You will receive:'),
                  SizedBox(
                    height: 5.h,
                  ),
                  plansViewModel.getPlanType == Plans.transitional.text
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orange14w400(
                                data: plansViewModel
                                    .getTransitional1to3PouchesText),
                            SizedBox(
                              height: 5.h,
                            ),
                            orange14w400(
                              data:
                                  plansViewModel.getTransitional4to6PouchesText,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            orange14w400(
                              data:
                                  plansViewModel.getTransitional7to9PouchesText,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            orange14w400(
                                data: plansViewModel
                                    .getTransitional10thPouchesText),
                          ],
                        )
                      : orange14w400(
                          data:
                              '${(totalPlanQuantity / perPouchQuantity).round()} servings x ${roundTo10(value: perPouchQuantity.toInt())} grams for ${plansViewModel.getFeedingPlan!.recipes[index].totalDays} days'),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                      child: black16w500(
                          data:
                              'Total Meal Price: ${plansViewModel.getFeedingPlan!.recipes[index].finalPrice!.toStringAsFixed(2)} AED')),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20.h,
            );
          },
        ),
      ),
    );
  }
}
