import 'package:brunos_kitchen/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../models/cart_model.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/images.dart';
import 'circular_network_image_widget.dart';

Widget cartDishVerticalListChipWidget({required RecipeModel cartRecipeModel}) {
  return Column(
    children: [
      InkWell(
        onTap: () {},
        child: Container(
          decoration: ShapeDecoration(
            color: CustomColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [ circularNetworkImageWidget(
                        image: cartRecipeModel.media!, size: 40.h),

                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        black14w500(data: cartRecipeModel.name!),
                        black14w500(data: 'Days: ${cartRecipeModel.totalDays}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}