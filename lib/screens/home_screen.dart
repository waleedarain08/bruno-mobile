import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/food_category_grid_chip_widget.dart';
import '../widgets/food_grid_chip_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGreyColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 150),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            purple10w500Centre(data: 'LOCATION'),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColors.purpleColor,
                            )
                          ],
                        ),
                        black14w400Centre(data: '46 Larkrow, London')
                      ],
                    ),
                    SvgPicture.asset(
                      shoppingIcon,
                      height: 44.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 200.w,
                child: const CarouselWidget(),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: CustomColors.linearGradient1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: black24w500Centre(
                          data:
                              'Trademarked Nutrient Blends, Exclusively Crafted for Your Pup\'s Special Needs.'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: black14w400Centre(
                          data:
                              'Sharing your love for pets and their wellbeing, we at Bruno\'s Kitchen have crafted a service that brings balanced, freshly-prepared pet food right to your doorstep. Our simple yet nutritious recipes are scientifically formulated and made with utmost love, because we believe your furry friends deserve the very best.'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: (1 / 0.7)),
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return foodCategoryGridChipWidget();
                      },
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: black24w500Centre(
                          data: 'Dive into a World of Paw-licking Goodness'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: black14w400Centre(
                    data: 'Check out our delicious doggie dishes'),
              ),
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: (1 / 1)),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return foodGridChipWidget();
                },
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: customButton(
                    text: 'Design Your Doggo\'s Delicious Diet Now',
                    onPressed: () {},
                    colored: true),
              ),
              SizedBox(height: 40.h),
              black24w500Centre(data: 'Our Pawfect Process'),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: ShapeDecoration(
                        color: CustomColors.lightBrownColor,
                        shape: OvalBorder(),
                      ),
                      child: Center(child: white18w500(data: '1')),
                    ),
                    SizedBox(width: 14.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 36.w,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                  child: black18w500(data: 'Get Personal'))),
                        black14w400Centre(
                          left: true,
                            data: 'Share details about your beloved pet. We deliver human-grade food in user-friendly packaging - minimal processing, stringent safety norms, and easy-to-serve: just open and serve!')
                      ],),
                    ),
                  ],),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: ShapeDecoration(
                        color: CustomColors.lightBrownColor,
                        shape: OvalBorder(),
                      ),
                      child: Center(child: white18w500(data: '2')),
                    ),
                    SizedBox(width: 14.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 36.w,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: black18w500(data: 'Choose Wisely'))),
                          black14w400Centre(
                              left: true,
                              data: 'Vet-designed plans tailored to your dog\'s unique needs. Pre-prepared and portioned meals calculated according to the profile you create, satisfying their calorie requirements with precision')
                        ],),
                    ),
                    SizedBox(width: 14.w,),
                  ],),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: ShapeDecoration(
                        color: CustomColors.lightBrownColor,
                        shape: OvalBorder(),
                      ),
                      child: Center(child: white18w500(data: '3')),
                    ),
                    SizedBox(width: 14.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 36.w,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: black18w500(data: 'Witness the Woofs'))),
                          black14w400Centre(
                              left: true,
                              data: 'Get ready for your pet\'s joy as their food arrives just days after cooking - never deep-frozen or shelf-stored for months. Watch them light up with Bruno\'s Kitchen!')
                        ],),
                    ),
                  ],),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Accordion(
                  maxOpenSections: 2,
                  headerBackgroundColorOpened: Colors.black54,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                 // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                 // sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                     // isOpen: false,
                      flipRightIconIfOpen: true,
                     rightIcon: Icon(Icons.keyboard_arrow_down),
                     // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                      headerBackgroundColor: CustomColors.whiteColor,
                      headerBackgroundColorOpened: CustomColors.whiteColor,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                            child: black14w400Centre(data: 'About Bruno’s Kitchen')),
                      ),
                      content: black12w500(data: 'When you start and order you can cancel it by clicking the logo on home page. You can find cancel button there.'),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                      // onOpenSection: () => print('onOpenSection ...'),
                      // onCloseSection: () => print('onCloseSection ...'),
                    ),
                    AccordionSection(
                     // isOpen: true,
                      flipRightIconIfOpen: true,
                      rightIcon: Icon(Icons.keyboard_arrow_down),
                      // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                      headerBackgroundColor: CustomColors.whiteColor,
                      headerBackgroundColorOpened: CustomColors.whiteColor,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black14w400Centre(data: 'About Bruno’s Kitchen')),
                      ),
                      content: black12w500(data: 'When you start and order you can cancel it by clicking the logo on home page. You can find cancel button there.'),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                      // onOpenSection: () => print('onOpenSection ...'),
                      // onCloseSection: () => print('onCloseSection ...'),
                    ),
                    AccordionSection(
                     // isOpen: true,
                      flipRightIconIfOpen: true,
                      rightIcon: Icon(Icons.keyboard_arrow_down),
                      // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                      headerBackgroundColor: CustomColors.whiteColor,
                      headerBackgroundColorOpened: CustomColors.whiteColor,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black14w400Centre(data: 'About Bruno’s Kitchen')),
                      ),
                      content: black12w500(data: 'When you start and order you can cancel it by clicking the logo on home page. You can find cancel button there.'),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                      // onOpenSection: () => print('onOpenSection ...'),
                      // onCloseSection: () => print('onCloseSection ...'),
                    ),
                    AccordionSection(
                      //isOpen: true,
                      flipRightIconIfOpen: true,
                      rightIcon: Icon(Icons.keyboard_arrow_down),
                      // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                      headerBackgroundColor: CustomColors.whiteColor,
                      headerBackgroundColorOpened: CustomColors.whiteColor,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black14w400Centre(data: 'About Bruno’s Kitchen')),
                      ),
                      content: black12w500(data: 'When you start and order you can cancel it by clicking the logo on home page. You can find cancel button there.'),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                      // onOpenSection: () => print('onOpenSection ...'),
                      // onCloseSection: () => print('onCloseSection ...'),
                    ),
                    AccordionSection(
                     // isOpen: true,
                      flipRightIconIfOpen: true,
                      rightIcon: Icon(Icons.keyboard_arrow_down),
                      // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                      headerBackgroundColor: CustomColors.whiteColor,
                      headerBackgroundColorOpened: CustomColors.whiteColor,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: black14w400Centre(data: 'About Bruno’s Kitchen')),
                      ),
                      content: black12w500(data: 'When you start and order you can cancel it by clicking the logo on home page. You can find cancel button there.'),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                      // onOpenSection: () => print('onOpenSection ...'),
                      // onCloseSection: () => print('onCloseSection ...'),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
