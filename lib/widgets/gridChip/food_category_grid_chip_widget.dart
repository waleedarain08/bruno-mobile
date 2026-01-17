import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/food_category_list_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/custom_colors.dart';

Widget foodCategoryGridChipWidget(
    {required FoodCategory listItems, required bool isBiggerThanMobile}) {
  return Card(
      elevation: 0,
      color: CustomColors.whiteColorTint,
      borderOnForeground: false,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: CustomColors.whiteColor),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              listItems.image!,
              height: isBiggerThanMobile ? 150.h : 42.h,
            ),
            if (isBiggerThanMobile)
              black24w500Centre(data: listItems.name!)
            else
              black12w500Centre(data: listItems.name!, centre: true)
          ],
        ),
      ));
}
