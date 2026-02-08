import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/images.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/puppy_view_model.dart';
import 'circular_network_image_widget.dart';

Widget defaultPuppyIconWidget() {
  return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
    return InkWell(
      onTap: () {
        if (authViewModel.getAuthResponse.data!.pet == null) {
          navigatorKey.currentContext!.read<PuppyViewModel>().clearPuppyData();
          Navigator.pushNamed(navigatorKey.currentContext!, puppyCreationRoute);
        } else {
          Navigator.pushNamed(navigatorKey.currentContext!, puppiesListRoute);
        }
        navigatorKey.currentContext!
            .read<PuppyViewModel>()
            .setRouteToPuppyFrom(Screens.profile.text);
      },
      child: Column(
        children: [
          authViewModel.getAuthResponse.data!.pet != null &&
                  authViewModel.getAuthResponse.data!.pet!.media!.isNotEmpty
              ? circularNetworkImageWidget(
                  image: authViewModel.getAuthResponse.data!.pet!.media!,
                  size: navigatorKey.currentContext!.isBiggerThanMobile
                      ? 40.h
                      : 30.h)
              : SizedBox(
                  height: navigatorKey.currentContext!.isBiggerThanMobile
                      ? 40.h
                      : 30.h,
                  width: navigatorKey.currentContext!.isBiggerThanMobile
                      ? 40.h
                      : 30.h,
                  child: SvgPicture.asset(dogProfileImage),
                ),
          authViewModel.getAuthResponse.data!.pet != null
              ? black10w400(
                  data: authViewModel.getAuthResponse.data!.pet!.name!
                      .substring(
                          0,
                          authViewModel
                                      .getAuthResponse.data!.pet!.name!.length >
                                  5
                              ? 5
                              : authViewModel
                                  .getAuthResponse.data!.pet!.name!.length),
                )
              : const SizedBox()
        ],
      ),
    );
  });
}
