import 'package:accordion/accordion.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/responses/faqs_blogs_news_response.dart';
import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/food_category_list_data.dart';
import '../utils/url_launcher.dart';
import '../utils/widget_utils.dart';
import '../view_models/bottom_navigation_view_model.dart';
import '../view_models/puppy_view_model.dart';
import '../widgets/carousels/home_carousel_widget.dart';
import '../widgets/cart_icon_widget.dart';
import '../widgets/deafult_puppy_icon_widget.dart';
import '../widgets/gridChip/food_category_grid_chip_widget.dart';
import '../widgets/gridChip/food_grid_chip_widget.dart';
import '../widgets/listChips/shop_items_horizontal_list_chip_widget.dart';
import '../widgets/location_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.whiteColorShade,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: context.isBiggerThanMobile ? 10.h : 20.h,
              bottom: 80.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).w,
                  child: Row(
                    spacing: 20.w,
                    children: [
                      LocationWidget(),
                      Spacer(),
                      cartIconWidget(),
                      defaultPuppyIconWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                _buildHomeView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeView(BuildContext context) {
    final bool isBiggerThanMobile = getIsBiggerThanMobile(context);
    return Column(
      children: [
        Visibility(
          visible: context.watch<AuthViewModel>().getBannerList.isNotEmpty,
          child: SizedBox(
            height: 200.w,
            width:
                isBiggerThanMobile ? MediaQuery.widthOf(context) * 0.5 : null,
            child: const HomeCarouselWidget(),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: CustomColors.linearGradient1),
          child: Center(
            child: SizedBox(
              width: getIsBiggerThanMobile(context)
                  ? MediaQuery.widthOf(context) * 0.5
                  : null,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).w,
                    child: black24w500Centre(
                        data:
                            'Trademarked Nutrient Blends, Exclusively Crafted For Your Pup\'s Special Needs'),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).w,
                    child: lightBlack14w400Centre(
                        data:
                            'Bruno\'s Kitchen brings balanced, freshly-prepared food to your doorstep. Our simple yet nutritious recipes are scientifically formulated and made with utmost love, because we believe your furry friends deserve the very best.'),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
                            .w,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                            childAspectRatio: (1 / 0.80)),
                    itemCount: foodCategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return foodCategoryGridChipWidget(
                        listItems: foodCategoryList[index],
                        isBiggerThanMobile: isBiggerThanMobile,
                      );
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                    child: black24w500Centre(
                        data: 'Dive into a World of Paw-licking Goodness'),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          width: getIsBiggerThanMobile(context)
              ? MediaQuery.widthOf(context) * 0.5
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: Row(
            children: [
              Expanded(
                  child: customButton(
                      height: 40.h,
                      text: FeaturedRecipeType.adult.text,
                      onPressed: () {
                        context
                            .read<PlansViewModel>()
                            .setSelectedFeaturedRecipe(
                                FeaturedRecipeType.adult.text);
                      },
                      colored: context
                              .watch<PlansViewModel>()
                              .getSelectedFeaturedRecipe ==
                          FeaturedRecipeType.adult.text)),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                  child: customButton(
                      height: 40.h,
                      text: FeaturedRecipeType.puppy.text,
                      onPressed: () {
                        context
                            .read<PlansViewModel>()
                            .setSelectedFeaturedRecipe(
                                FeaturedRecipeType.puppy.text);
                      },
                      colored: context
                              .watch<PlansViewModel>()
                              .getSelectedFeaturedRecipe ==
                          FeaturedRecipeType.puppy.text)),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Wrap(
          runSpacing: 20,
          spacing: 20,
          alignment: WrapAlignment.center,
          children: List.generate(
              context
                  .watch<PlansViewModel>()
                  .getSelectedFeaturedRecipesList
                  .length, (index) {
            return SizedBox(
              width: 157.w,
              child: foodGridChipWidget(
                  recipeDetail: context
                      .watch<PlansViewModel>()
                      .getSelectedFeaturedRecipesList[index]),
            );
          }),
        ),
        SizedBox(height: 30.h),
        Container(
          width: getIsBiggerThanMobile(context)
              ? MediaQuery.widthOf(context) * 0.5
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: customButton(
              text: 'Order Your Doggo\'s Meals Now',
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
                      .setRouteToPuppyFrom(Screens.home.text);
                  context.read<PuppyViewModel>().clearPuppyData();
                  Navigator.pushNamed(context, puppyCreationRoute);
                } else {
                  Navigator.pushNamed(context, choosePlanRoute);
                }
                /*   SendGridPref sendGrid = SendGridPref();
                      sendGrid.sendEmail(emailSubject: 'Registration', emailDescription: 'Register Successfully');
    */
              },
              colored: true),
        ),
        SizedBox(height: 40.h),
        black24w500Centre(data: 'Our Pawfect Process'),
        SizedBox(height: 15.h),
        Container(
          width: getIsBiggerThanMobile(context)
              ? MediaQuery.widthOf(context) * 0.5
              : null,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: ShapeDecoration(
                      color: CustomColors.lightBrownColor,
                      shape: const OvalBorder(),
                    ),
                    child: Center(child: white18w500(data: '1')),
                  ),
                  const Dash(
                      direction: Axis.vertical,
                      length: 120,
                      dashLength: 10,
                      dashColor: CustomColors.brownColor),
                ],
              ),
              SizedBox(
                width: 14.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 36.w,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black18w500(data: 'Get Personal'))),
                    lightBlack14w400Centre(
                        left: true,
                        data:
                            'Share details about your beloved pet. We deliver human-grade food in user-friendly packaging - minimal processing, stringent safety norms, and easy-to-eat: just open and serve!')
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: getIsBiggerThanMobile(context)
              ? MediaQuery.widthOf(context) * 0.5
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: ShapeDecoration(
                      color: CustomColors.lightBrownColor,
                      shape: const OvalBorder(),
                    ),
                    child: Center(child: white18w500(data: '2')),
                  ),
                  const Dash(
                      direction: Axis.vertical,
                      length: 120,
                      dashLength: 10,
                      dashColor: CustomColors.brownColor),
                ],
              ),
              SizedBox(
                width: 14.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 36.w,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black18w500(data: 'Choose Wisely'))),
                    lightBlack14w400Centre(
                        left: true,
                        data:
                            'Vet-designed plans tailored to your dog\'s unique needs. Pre-prepared and portioned meals calculated according to the profile you create, satisfying their caloric requirements with precision.')
                  ],
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
            ],
          ),
        ),
        Container(
          width: getIsBiggerThanMobile(context)
              ? MediaQuery.widthOf(context) * 0.5
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: ShapeDecoration(
                  color: CustomColors.lightBrownColor,
                  shape: const OvalBorder(),
                ),
                child: Center(child: white18w500(data: '3')),
              ),
              SizedBox(
                width: 14.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 36.w,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black18w500(data: 'Witness the Woofs'))),
                    lightBlack14w400Centre(
                        left: true,
                        data:
                            'Get ready for your pet\'s joy as their food arrives just days after cooking - never deep-frozen or shelf-stored for months. Watch them light up with Bruno\'s Kitchen!')
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: InkWell(
              onTap: () {
                context.read<BottomNavigationViewModel>().setHomeViewIndex(1);
              },
              child: Image.asset(dogBanner)),
        ),
        SizedBox(
          height: 20.h,
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          //  itemCount: 3,
          /* itemBuilder: (BuildContext context, int index) =>*/
          child: Row(
            children: context
                .watch<PlansViewModel>()
                .getFeaturedProductList
                .map(
                  (data) => Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 159.w,
                    child:
                        shopItemsHorizontalListChipWidget(productDetail: data),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        context.watch<PlansViewModel>().getRecipesListResponse.data != null
            ? SizedBox(
                width: getIsBiggerThanMobile(context)
                    ? MediaQuery.widthOf(context) * 0.5
                    : null,
                child: Column(
                  children: [
                    black24w500Centre(data: 'Frequently Asked Questions'),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, faqRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: black12w500Centre(data: 'View all')),
                      ),
                    ),
                    Accordion(
                      disableScrolling: true,
                      paddingListHorizontal: 20,
                      maxOpenSections: 2,
                      headerBackgroundColorOpened: Colors.black54,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15)
                          .w,
                      // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      // sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: [
                        for (FaqsBlogsNewsData item in context
                            .watch<PlansViewModel>()
                            .getRecipesListResponse
                            .data!
                            .faqs!)
                          AccordionSection(
                            // isOpen: false,
                            // flipRightIconIfOpen: true,
                            rightIcon: const Icon(Icons.keyboard_arrow_down),
                            // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                            headerBackgroundColor: CustomColors.whiteColor,
                            headerBackgroundColorOpened:
                                CustomColors.whiteColor,
                            header: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5).w,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: lightBlack14w400Centre(
                                      data: item.title!)),
                            ),
                            content: black12w500Centre(data: item.description!),
                            contentHorizontalPadding: 20,
                            contentBorderWidth: 1,
                            // onOpenSection: () => print('onOpenSection ...'),
                            // onCloseSection: () => print('onCloseSection ...'),
                          )
                      ],
                    )
                  ],
                ),
              )
            : const SizedBox(),
        SvgPicture.asset(
          logoImage,
          width: 200.w,
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {
            urlLauncher(url: webUrl);
          },
          child: Container(
            decoration: BoxDecoration(
              color: CustomColors.lightBlackColor,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10).w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  white18w500(data: 'Visit'),
                  SizedBox(
                    width: 5.w,
                  ),
                  orange18w500(data: 'brunos.kitchen'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).w,
          child: Row(
            mainAxisAlignment: isBiggerThanMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            spacing: 20.w,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero),
                  onPressed: () {
                    urlLauncher(url: agreementUrl);
                  },
                  child: black10w400(data: 'User Service Agreement')),
              TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero),
                  onPressed: () {
                    urlLauncher(url: termAndConditionUrl);
                  },
                  child: black10w400(data: 'Terms & Conditions')),
              TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero),
                  onPressed: () {
                    urlLauncher(url: privacyPolicyUrl);
                  },
                  child: black10w400(data: 'Privacy Policy')),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
