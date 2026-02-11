import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:brunos_kitchen/widgets/web_card_widget.dart';
import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/plans_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/bottomSheet/add_meal_bottom_sheet_widget.dart';
import '../widgets/circular_network_image_widget.dart';
import '../widgets/dialogs/discription_dialog.dart';

class MonthlyPlanScreen extends StatelessWidget {
  const MonthlyPlanScreen({super.key});

  int calculateTotalDays({required PlansViewModel viewModel}) {
    final numberOfDays = (viewModel.getMonthlyEmptyTile1 != null
            ? viewModel.getMonthlyEmptyTile1!.totalDays!
            : 0) +
        (viewModel.getMonthlyEmptyTile2 != null
            ? viewModel.getMonthlyEmptyTile2!.totalDays!
            : 0) +
        (viewModel.getMonthlyEmptyTile3 != null
            ? viewModel.getMonthlyEmptyTile3!.totalDays!
            : 0);
    return numberOfDays;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansViewModel>(
      builder: (context, plansViewModel, child) {
        return SafeArea(
          child: CustomScaffold(
            appBar: const AppBarWithBackWidget(
              heading: 'Monthly Plan',
              showPuppy: true,
              showCart: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20).w,
              child: Stack(
                children: [
                  WebSizedBox(
                    child: WebCardWidget(
                      child: Padding(
                        padding: context.isBiggerThanMobile
                            ? EdgeInsets.all(20.w)
                            : EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: black24w500Centre(
                                data:
                                    'Let’s Feed Your Beloved\n${context.watch<AuthViewModel>().getAuthResponse.data?.pet?.name ?? 'Pet'}',
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                                child: lightBlack14w400Centre(
                                    data:
                                        'You can select any two delicious dishes up to 30 days (min is 15 days)')),
                            SizedBox(
                              height: 30.h,
                            ),
                            black18w500(data: 'Add Dishes'),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                plansViewModel.setMonthlyEmptyTileNumber(1);
                                addMealDetailBottomSheetWidget();
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: CustomColors.lightGreyColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 22)
                                      .w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: ShapeDecoration(
                                            color: CustomColors.whiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                          ),
                                          child: plansViewModel
                                                      .getMonthlyEmptyTile1 !=
                                                  null
                                              ? circularNetworkImageWidget(
                                                  image: plansViewModel
                                                      .getMonthlyEmptyTile1!
                                                      .media![0],
                                                  size: 52.h,
                                                )
                                              : SizedBox(
                                                  height: 52.h,
                                                  width: 52.h,
                                                )),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          plansViewModel.getMonthlyEmptyTile1 !=
                                                  null
                                              ? black16w500(
                                                  data:
                                                      'Days ${plansViewModel.getMonthlyEmptyTile1!.totalDays}')
                                              : black16w500(
                                                  data: 'Tap to Add Meal'),
                                          plansViewModel.getMonthlyEmptyTile1 !=
                                                  null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 5.0)
                                                          .w,
                                                  child: black14w500(
                                                      data: plansViewModel
                                                          .getMonthlyEmptyTile1!
                                                          .name!),
                                                )
                                              : Container(),

                                          /*     Visibility(
                                          visible: plansViewModel.getScheduleEmptyTile1 == null,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: black12w500Centre(data: 'tap to add meal'),
                                          ),
                                        )*/
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: const ShapeDecoration(
                                          color: CustomColors.orangeColor,
                                          shape: OvalBorder(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10).w,
                                          child: Icon(
                                            plansViewModel
                                                        .getMonthlyEmptyTile1 ==
                                                    null
                                                ? Icons.add
                                                : Icons.edit_outlined,
                                            size: 20,
                                            color: CustomColors.whiteColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                plansViewModel.setMonthlyEmptyTileNumber(2);
                                addMealDetailBottomSheetWidget();
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: CustomColors.lightGreyColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 22)
                                      .w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: ShapeDecoration(
                                            color: CustomColors.whiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                          ),
                                          child: plansViewModel
                                                      .getMonthlyEmptyTile2 !=
                                                  null
                                              ? circularNetworkImageWidget(
                                                  image: plansViewModel
                                                      .getMonthlyEmptyTile2!
                                                      .media![0],
                                                  size: 52.h,
                                                )
                                              : SizedBox(
                                                  height: 52.h,
                                                  width: 52.h,
                                                )),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          plansViewModel.getMonthlyEmptyTile2 !=
                                                  null
                                              ? black16w500(
                                                  data:
                                                      'Days ${plansViewModel.getMonthlyEmptyTile2!.totalDays}')
                                              : black16w500(
                                                  data: 'Tap to Add Meal'),
                                          plansViewModel.getMonthlyEmptyTile2 !=
                                                  null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 5.0)
                                                          .w,
                                                  child: black14w500(
                                                      data: plansViewModel
                                                          .getMonthlyEmptyTile2!
                                                          .name!),
                                                )
                                              : Container(),

                                          /*     Visibility(
                                          visible: plansViewModel.getScheduleEmptyTile1 == null,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: black12w500Centre(data: 'tap to add meal'),
                                          ),
                                        )*/
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: const ShapeDecoration(
                                          color: CustomColors.orangeColor,
                                          shape: OvalBorder(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10).w,
                                          child: Icon(
                                            plansViewModel
                                                        .getMonthlyEmptyTile2 ==
                                                    null
                                                ? Icons.add
                                                : Icons.edit_outlined,
                                            size: 20,
                                            color: CustomColors.whiteColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            black14w400(
                                data:
                                    'Please make sure your pup\'s profile is up to date in order to get the right nutritional amount for an ultimate feeding experience!'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Align(
                      alignment: context.isBiggerThanMobile
                          ? Alignment.bottomRight
                          : Alignment.bottomCenter,
                      child: Container(
                        width: context.isBiggerThanMobile ? 0.2.sw : null,
                        padding: EdgeInsets.only(top: 20.w),
                        child: customButton(
                            text: 'Continue',
                            onPressed: () {
                              if (plansViewModel.getMonthlyEmptyTile1 == null &&
                                  plansViewModel.getMonthlyEmptyTile2 == null &&
                                  plansViewModel.getMonthlyEmptyTile3 == null) {
                                descriptionDialog(
                                  context: context,
                                  description: 'Please add at least One Meal',
                                  height: context.isBiggerThanMobile
                                      ? 150.w
                                      : 150.h,
                                  title: 'Note',
                                );
                              } else {
                                if (calculateTotalDays(
                                            viewModel: plansViewModel) <
                                        15 ||
                                    calculateTotalDays(
                                            viewModel: plansViewModel) >
                                        30) {
                                  descriptionDialog(
                                      context: context,
                                      description:
                                          'Total number of days must be min 15 and max 30',
                                      height: context.isBiggerThanMobile
                                          ? 150.w
                                          : 150.h,
                                      title: 'Alert');
                                } else {
                                  context
                                      .read<CartViewModel>()
                                      .setViewCartItemDetail(false);
                                  Navigator.pushNamed(
                                      context, feedingPlanRoute);
                                }
                              }
                            },
                            colored: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
