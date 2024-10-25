import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_colors.dart';

Widget customButton ({required String text,required VoidCallback onPressed, required bool colored}){
  return SizedBox(
    height: 50.h,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colored ? CustomColors.orangeColor : CustomColors.whiteColor,
        shape: const StadiumBorder(side: BorderSide(width: 1.0,color: CustomColors.orangeColor)),
      ),
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: colored ? CustomColors.whiteColor : CustomColors.orangeColor,)),
    ),
  );
}




