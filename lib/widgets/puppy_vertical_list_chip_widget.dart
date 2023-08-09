
import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/models/responses/puppies_response.dart';
import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:brunos_kitchen/widgets/circular_network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/puppy_model.dart';
import '../route_generator.dart';
import '../utils/custom_font_style.dart';
import '../utils/images.dart';

Widget puppyVerticalListChipWidget({required PuppyModel puppyDetail}) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          navigatorKey.currentContext!.read<PuppyViewModel>().setPuppyDetail(puppyDetail);
          Navigator.pushNamed(navigatorKey.currentContext!, puppyDetailRoute);
        },
        child: Container(
          decoration: ShapeDecoration(
            color: CustomColors.lightGreyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                circularNetworkImageWidget(image: puppyDetail.media!, size: 40.h),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    black14w400Centre(data: puppyDetail.name!),
                    grey12w500(data: puppyDetail.breed!),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: ShapeDecoration(
                      color: CustomColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.75, color: CustomColors.greyMediumColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: CustomColors.orangeColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
    ],
  );
}
