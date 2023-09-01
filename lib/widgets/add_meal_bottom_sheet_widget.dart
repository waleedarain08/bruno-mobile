
import 'package:brunos_kitchen/models/dishes_model.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/widgets/meal_vertical_list_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utils/custom_colors.dart';

Future addMealDetailBottomSheetWidget() {
  return showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: CustomColors.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          black24w500Centre(data: 'Add Meal'),
                          SizedBox(
                            height: 5.h,
                          ),
                          grey14w400(data: 'Day 1-11'),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
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
                      )
                    ],
                  ),

                  SizedBox(
                    height: 500.h,
                    child: ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dishList.length,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return mealVerticalListChipWidget(dishData: dishList[index]);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}