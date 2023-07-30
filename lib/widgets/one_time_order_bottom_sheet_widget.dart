import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/images.dart';
import 'meal_vertical_list_chip_widget.dart';

Future oneTimeOrderBottomSheetWidget() {
  return showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: CustomColors.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context:  navigatorKey.currentContext!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          color: CustomColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.75,
                                color: CustomColors.greyMediumColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.clear,
                            size: 20,
                            color: CustomColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      food,
                      height: 122.h,
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      black14w400Centre(data: 'Mighty Chicken'),
                      black10w400(data: 'High protein, grain-free,\npicky eater approved'),
                        SizedBox(height: 5.h,),
                        orange14w400(data: 'AED 100 / plan')
                    ],),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        black14w400Centre(data: 'Quantity'),
                        SizedBox(height: 5.h,),
                        Row(children: [
                          InkWell(
                            onTap: (){
                             // Navigator.pop(context);
                            },
                            child: Container(
                              decoration: ShapeDecoration(
                                color: CustomColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.75,
                                      color: CustomColors.greyMediumColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: CustomColors.greyColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                              child: Center(child: black18w500(data: '1'))),
                          InkWell(
                            onTap: (){
                              //Navigator.pop(context);
                            },
                            child: Container(
                              decoration: ShapeDecoration(
                                color: CustomColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.75,
                                      color: CustomColors.greyMediumColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: CustomColors.greyColor,
                                ),
                              ),
                            ),
                          ),
                        ],)
                      ],)

                  ],),
                  SizedBox(height: 40.h,),
                  customButton(text: 'Continue', onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, deliveryDatesRoute);
                  }, colored: true),
                ],
              ),
            ],
          ),
        );
      });
}