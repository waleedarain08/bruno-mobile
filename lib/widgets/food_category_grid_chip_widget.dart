import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/custom_colors.dart';

Widget foodCategoryGridChipWidget (){
  return Card(
    elevation: 0,
    color: CustomColors.whiteColorTint,
    borderOnForeground: false,
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: CustomColors.whiteColor),
      borderRadius: BorderRadius.all(
          Radius.circular(20)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(foodCategory,height: 42.h,),
          black12w500(data: 'Freshly cooked')
        ],
      ),
    ));
}