import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../utils/navigations_validation.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/dialogs/discription_dialog.dart';

class ChooseYourPlanScreen extends StatelessWidget {
  const ChooseYourPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWithBackWidget(
            heading: 'Choose your plan', showPuppy: true, showCart: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Image.asset(
                  buyBulits2,
                  height: 57.h,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                    child: black24w500Centre(
                        data:
                            'Create A Paw-Licking\nGood Meal Plan For ${context.watch<AuthViewModel>().getAuthResponse.data!.pet!.name!}'),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                InkWell(
                  onTap: () {
                    if (context
                        .read<CartViewModel>()
                        .checkCartForPlanValidation(
                            planType: Plans.transitional.text)) {
                      context
                          .read<PlansViewModel>()
                          .setPlanType(Plans.transitional);
                      context.read<PlansViewModel>().clearPlanData();
                      Navigator.pushNamed(context, transitionPlanRoute);
                    } else {
                      Navigator.pushNamed(context, cartRoute);
                      descriptionDialog(
                          context: context,
                          description:
                              'To add new plan for ${context.read<AuthViewModel>().getAuthResponse.data!.pet!.name} you have to remove current ${context.read<AuthViewModel>().getAuthResponse.data!.pet!.name} plan from shopping bag',
                          height: 180.h,
                          title: 'New Plan Creation');
                    }
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: CustomColors.greyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            descriptionDialog(
                                context: context,
                                description:
                                    'A 10 days feeding plan to ensure your pup’s tummy transitions to our food smoothly and without any dietary difficulties. We prepare and portion the food for you. Just ensure your Pet’s profile information is completed.\nRefer to FAQs page for the transition feeding guidelines.',
                                height: 280.h,
                                title: 'Transitional Plan');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).w,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(informationButton)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20).w,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                transitionPlan,
                                height: 44.h,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    black18w500(data: 'Transitional Plan'),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    lightBlack14w400Centre(
                                        data:
                                            'First timers: Ease into Bruno’s recipes',
                                        left: true)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    navigateToMonthlyPlans(context: context);
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: CustomColors.greyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            descriptionDialog(
                                context: context,
                                description:
                                    'The BIG SAVER option, you can choose any two recipes for up to 30 days of food supply. Ensuring you have enough food for your pup to enjoy for the entire month at a special discounted price. We prepare and portion the food for you for a hassle-free feeding experience.',
                                height: 230.h,
                                title: 'Monthly Order');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).w,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(informationButton)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20).w,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                monthlyPlan,
                                height: 44.h,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    black18w500(data: 'Monthly Order'),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    lightBlack14w400Centre(
                                        data:
                                            'An affordable, varied meal adventure!',
                                        left: true),
                                    //SizedBox(height: 10.h,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10).w,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: orange14w500(
                                              data: context
                                                          .watch<
                                                              AuthViewModel>()
                                                          .getAuthResponse
                                                          .data!
                                                          .discounts![3]
                                                          .aggregate !=
                                                      0
                                                  ? 'Save upto ${context.watch<AuthViewModel>().getAuthResponse.data!.discounts![3].aggregate}%'
                                                  : 'Order for up to a month and save!')),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    //TODO: REMOVE ONETIME ORDER
                    if (context
                        .read<CartViewModel>()
                        .checkCartForPlanValidation(
                            planType: Plans.product.text)) {
                      context.read<PlansViewModel>().setPlanType(Plans.product);
                      context.read<PlansViewModel>().clearPlanData();
                      Navigator.pushNamed(context, oneTimePlanRoute);
                    } else {
                      Navigator.pushNamed(context, cartRoute);
                      descriptionDialog(
                          context: context,
                          description:
                              'To add new plan for ${context.read<AuthViewModel>().getAuthResponse.data!.pet!.name} you have to remove current ${context.read<AuthViewModel>().getAuthResponse.data!.pet!.name} plan from shopping bag',
                          height: 180.h,
                          title: 'New Plan Creation');
                    }
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: CustomColors.greyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            descriptionDialog(
                                context: context,
                                description:
                                    'Select your preference of our standard-size pouches for your pup. Perfect for short-term feeding requirements.',
                                height: 160.h,
                                title: 'One-time Plan');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).w,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(informationButton)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20).w,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                onetimePlan,
                                height: 44.h,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    black18w500(data: 'One-time Order'),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    lightBlack14w400Centre(
                                        data: 'Still not sure? Try us out!',
                                        left: true)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
