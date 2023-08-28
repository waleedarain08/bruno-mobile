import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:brunos_kitchen/widgets/recipe_detail_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/enums.dart';

Widget shopItemsHorizontalListChipWidget() {
  return InkWell(
    onTap: () {
     /* navigatorKey.currentContext!.read<PlansViewModel>().getPlanType ==
          Plans.oneTime.text
          ? oneTimeOrderBottomSheetWidget()
          : Navigator.pushNamed(
          navigatorKey.currentContext!, deliveryDatesRoute);*/
    },
    child: Card(
        elevation: 8,
        color: CustomColors.whiteColor,
        borderOnForeground: false,
        shape: const RoundedRectangleBorder(
          // side: BorderSide(color: CustomColors.whiteColor),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: CustomColors.lightGreyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      bone,
                      height: 108.h,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 12, bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    black14w400(data: 'Wishbone Bacon Chew Toy For Dogs'),
                    SizedBox(
                      height: 6.h,
                    ),
                    brown12w500Centre(data: 'AED 50'),
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}