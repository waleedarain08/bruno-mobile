import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_colors.dart';

Widget black32w500Center({required String data}) {
  return Text(
    data,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 32.sp,
        color: CustomColors.blackColor,
        fontWeight: FontWeight.w500),
  );
}

Widget black24w500Centre({required String data}) {
  return Text(
    data,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 24.sp,
        color: CustomColors.blackColor,
        fontWeight: FontWeight.w500),
  );
}

Widget lightBlack14w400Centre({required String data, bool? left}) {
  return Text(
    data,
    textAlign: left != null ? TextAlign.left : TextAlign.center,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        height: 1.3,
        color: CustomColors.lightBlackColor,
        fontWeight: FontWeight.w400),
  );
}

Widget purple10w500Centre({required String data}) {
  return Text(
    data,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 10.sp,
        color: CustomColors.purpleColor,
        fontWeight: FontWeight.w500),
  );
}

Widget black14w500({required String data, bool? centre}) {
  return Text(
    textAlign:
        centre != null && centre == true ? TextAlign.center : TextAlign.left,
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        color: CustomColors.blackColor,
        fontWeight: FontWeight.w500),
  );
}

Widget black14w400({required String data, bool? lineSpacing}) {
  return Text(
    data,
    style: TextStyle(
        height: lineSpacing == true ? 1.5 : null,
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        color: CustomColors.blackColor,
        fontWeight: FontWeight.w400),
  );
}

//google font, color color2, size 12, bold
Widget googleFont2({required String data, bool? click}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 12.sp,
        color: click != null && click
            ? CustomColors.orangeColor
            : CustomColors.purpleColor,
        fontWeight: FontWeight.bold),
  );
}

Widget yellow10w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 10.sp,
        color: CustomColors.yellowColor,
        fontWeight: FontWeight.w500),
  );
}

Widget black18w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 18.sp,
        color: CustomColors.blackColor,
        fontWeight: FontWeight.w500),
  );
}

Widget brown32w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 32.sp,
        color: CustomColors.brownColor,
        fontWeight: FontWeight.w500),
  );
}

Widget brown14w400Centre({required String data, bool? centre}) {
  return Text(
    data,
    textAlign:
        centre != null && centre == true ? TextAlign.center : TextAlign.left,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        color: CustomColors.brownColor,
        fontWeight: FontWeight.w400),
  );
}

Widget brown12w500Centre({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 12.sp,
        color: CustomColors.brownColor,
        fontWeight: FontWeight.w500),
  );
}

Widget grey14w400HeightCentre({required String data}) {
  return Text(
    data,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        height: 1.8,
        fontWeight: FontWeight.w400,
        color: CustomColors.greyColor),
  );
}

Widget grey14w400({required String data, bool? lineHeight, int? maxLine}) {
  return Text(
    maxLines: maxLine,
    data,
    style: TextStyle(
        height: lineHeight == true ? 1.5 : null,
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: CustomColors.greyColor),
  );
}

Widget grey12w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: CustomColors.greyColor),
  );
}

Widget orange14w400({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: CustomColors.orangeColor),
  );
}

Widget orange14w500({required String data, TextAlign? align}) {
  return Text(
    textAlign: align,
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: CustomColors.orangeColor),
  );
}

Widget orange18w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: CustomColors.orangeColor),
  );
}

Widget black12w500Centre(
    {required String data,
    bool? centre,
    bool? overFlowText,
    bool? lineSpacing}) {
  return Text(
    maxLines: overFlowText != null && overFlowText ? 1 : null,
    overflow:
        overFlowText != null && overFlowText ? TextOverflow.ellipsis : null,
    data,
    textAlign:
        centre != null && centre == true ? TextAlign.center : TextAlign.left,
    style: TextStyle(
        height: lineSpacing == true ? 1.5 : null,
        fontFamily: 'CircularStd',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: CustomColors.blackColor),
  );
}

Widget black10w400({required String data, int? maxLine}) {
  return Text(
    data,
    maxLines: maxLine,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: CustomColors.blackColor),
  );
}

Widget black16w500({required String data, TextAlign? align}) {
  return Text(
    data,
    textAlign: align,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: CustomColors.blackColor),
  );
}

Widget white18w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: CustomColors.whiteColor),
  );
}

Widget whiteTint14w400({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: CustomColors.whiteColorTint),
  );
}

Widget white12w400({required String data, bool? overFlowText}) {
  return Text(
    maxLines: overFlowText != null && overFlowText ? 1 : null,
    overflow:
        overFlowText != null && overFlowText ? TextOverflow.ellipsis : null,
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: CustomColors.whiteColor),
  );
}

Widget white8w500({required String data}) {
  return Text(
    data,
    style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 8.sp,
        fontWeight: FontWeight.w500,
        color: CustomColors.whiteColor),
  );
}
