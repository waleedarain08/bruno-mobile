import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../utils/calculations.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../view_models/cart_view_model.dart';
import '../view_models/plans_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';

class FeedingPlanScreen extends StatefulWidget {
  const FeedingPlanScreen({super.key});

  @override
  State<FeedingPlanScreen> createState() => _FeedingPlanScreenState();
}

class _FeedingPlanScreenState extends State<FeedingPlanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PlansViewModel>().setFeedingPlan(
          petData: context.read<AuthViewModel>().getAuthResponse.data!.pet!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansViewModel>(builder: (context, plansViewModel, child) {
      return Scaffold(
        appBar: AppBarWithBackWidget(
            heading: plansViewModel.getPlanType == Plans.transitional.text
                ? 'Transitional Feeding Plan'
                : plansViewModel.getPlanType == Plans.monthly.text
                    ? 'Monthly Feeding Plan'
                    : 'One time Feeding Order',
            showPuppy: false,
            showCart: !context.read<CartViewModel>().getViewCartItemDetail),
        body: Stack(
          children: [
            plansViewModel.getFeedingPlan != null
                ? ListView.separated(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: plansViewModel.getFeedingPlan!.recipes.length,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 200),
                    itemBuilder: (BuildContext context, int index) {
                      final num totalPlanQuantity = calculateDailyIntake(
                              recipeModel:
                                  plansViewModel.getFeedingPlan!.recipes[index],
                              puppyActivityLevel: plansViewModel
                                  .getFeedingPlan!.pet!.activityLevel!,
                              currentWeight: plansViewModel
                                  .getFeedingPlan!.pet!.currentWeight!) *
                          (plansViewModel
                              .getFeedingPlan!.recipes[index].totalDays!);
                      final num perPouchQuantity = calculateFeedingPlan(
                          recipeModel:
                              plansViewModel.getFeedingPlan!.recipes[index],
                          puppyModel: plansViewModel.getFeedingPlan!.pet!);
                      final num transitionalPlanTotalQuantity =
                          plansViewModel.getTotalTransitionalGrams();
                      final num transitional1to3PerPouchQty =
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
                                  plansViewModel.getTransitionalGrams10thDay);
                      return ListTile(
                        minVerticalPadding: 20,
                        title: orange18w500(
                            data: plansViewModel
                                .getFeedingPlan!.recipes[index].name!),
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
                            plansViewModel.getPlanType ==
                                    Plans.transitional.text
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      orange14w400(
                                          data:
                                              '${(plansViewModel.getTransitionalGrams1to3Days / transitional1to3PerPouchQty * 3).round()} pouches x ${(transitional1to3PerPouchQty / 3).toStringAsFixed(2)} grams (for days 1 to 3)'),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      orange14w400(
                                          data:
                                              '${(plansViewModel.getTransitionalGrams4to6Days / transitional4to6PerPouchQty * 3).round()} pouches x ${(transitional4to6PerPouchQty / 3).toStringAsFixed(2)} grams (for days 4 to 6)'),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      orange14w400(
                                          data:
                                              '${(plansViewModel.getTransitionalGrams7to9Days / transitional7to9PerPouchQty * 3).round()} pouches x ${(transitional7to9PerPouchQty / 3).toStringAsFixed(2)} grams (for days 7 to 9)'),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      orange14w400(
                                          data:
                                              '${(plansViewModel.getTransitionalGrams10thDay / transitional10thPerPouchQty).round()} pouches x ${transitional10thPerPouchQty.toStringAsFixed(1)} grams (for day 10 onwards)'),
                                    ],
                                  )
                                : orange14w400(
                                    data:
                                        '${(totalPlanQuantity / perPouchQuantity).round()} pouches x $perPouchQuantity grams for ${plansViewModel.getFeedingPlan!.recipes[index].totalDays} days'),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                                child: black16w500(
                                    data:
                                        'Total Meal Price: ${plansViewModel.getFeedingPlan!.recipes[index].finalPrice} AED')),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                  )
                : const SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 2,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      orange14w500(
                          data:
                              'Total ${plansViewModel.getPlanType} Plan Price = ${plansViewModel.getFeedingPlan!.planTotal} AED'),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                          width: 250.w,
                          child: black12w500Centre(
                              data:
                                  'The above plan is calculated based on ${plansViewModel.getFeedingPlan!.pet!.name!}\'s profile data',
                              centre: true)),
                      SizedBox(
                        height: 20.h,
                      ),
                      customButton(
                          text: !context
                                  .read<CartViewModel>()
                                  .getViewCartItemDetail
                              ? 'Add to Sopping Bag'
                              : 'Shopping Bag',
                          onPressed: () {
                            if (!context
                                .read<CartViewModel>()
                                .getViewCartItemDetail) {
                              context.read<CartViewModel>().addToCartList(
                                    CartModel(
                                        recipes: plansViewModel
                                            .getFeedingPlan!.recipes,
                                        pet: plansViewModel
                                            .getFeedingPlan!.pet,
/*
                                deliveryDate: deliveryDate,
*/
                                        planType: plansViewModel
                                            .getFeedingPlan!.planType,
                                        planTotal: plansViewModel
                                            .getFeedingPlan!.planTotal),
                                  );
                              if (context
                                      .read<CartViewModel>()
                                      .getSelectedIndex ==
                                  null) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    bottomNavigationRoute, (route) => false);
                              } else {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    cartRoute, (Route route) => route.isFirst);
                              }

                              EasyLoading.showToast(
                                  '${plansViewModel.getPlanType} Plan Successfully Added To\nShopping Bag',
                                  toastPosition:
                                      EasyLoadingToastPosition.center);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          colored: true),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
