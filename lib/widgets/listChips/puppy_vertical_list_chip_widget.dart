import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:brunos_kitchen/widgets/circular_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/puppy_model.dart';
import '../../route_generator.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/images.dart';
import '../../view_models/bottom_navigation_view_model.dart';

Widget puppyVerticalListChipWidget({required PuppyModel puppyDetail}) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          if (navigatorKey.currentContext!
                  .read<BottomNavigationViewModel>()
                  .getHomeViewIndex !=
              2) {
            navigatorKey.currentContext!
                .read<AuthViewModel>()
                .setPuppy(puppyDetail);
            Navigator.pop(navigatorKey.currentContext!);
          } else {
            navigatorKey.currentContext!
                .read<PuppyViewModel>()
                .setPuppyDetail(puppyDetail);
            Navigator.pushNamed(navigatorKey.currentContext!, puppyDetailRoute);
          }
        },
        child: Container(
          decoration: ShapeDecoration(
            color: CustomColors.lightGreyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20).w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                puppyDetail.media!.isNotEmpty
                    ? circularNetworkImageWidget(
                        image: puppyDetail.media!, size: 40.h)
                    : SizedBox(
                        height: 40.h,
                        width: 40.h,
                        child: CircleAvatar(
                          backgroundColor: CustomColors.yellowColor,
                          child: SvgPicture.asset(dogFace),
                        ),
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    lightBlack14w400Centre(data: puppyDetail.name!),
                    grey12w500(data: puppyDetail.breed!),
                    Visibility(
                      visible: puppyDetail.isDefault!,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: CustomColors.orangeColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 2),
                                child: white12w400(data: 'Primary'),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    navigatorKey.currentContext!
                        .read<PuppyViewModel>()
                        .setPuppyDetail(puppyDetail);
                    Navigator.pushNamed(
                        navigatorKey.currentContext!, puppyDetailRoute);
                  },
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
                        Icons.sticky_note_2_outlined,
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
