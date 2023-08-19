import 'package:brunos_kitchen/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_colors.dart';
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
          navigatorKey.currentContext!.read<PuppyViewModel>().setRouteToPuppyFrom(Screens.profile.text);
          navigatorKey.currentContext!.read<PuppyViewModel>().clearPuppyData();
          Navigator.pushNamed(navigatorKey.currentContext!, puppyCreationRoute);
        } else {
          Navigator.pushNamed(navigatorKey.currentContext!, puppiesListRoute);
        }
      },
      child: Stack(
        children: [
          SizedBox(
            height: 40.h,
            width: 110.w,
            child: Center(
              child: SizedBox(
                width: 110.w,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, top: 5, bottom: 5, left: 50),
                  child: black12w500Centre(
                      overFlowText: true,
                      data: authViewModel.getAuthResponse.data!.pet != null
                          ? authViewModel.getAuthResponse.data!.pet!.name!
                          : 'Add Pet'),
                ),
              ),
            ),
          ),
          authViewModel.getAuthResponse.data!.pet != null &&
                  authViewModel.getAuthResponse.data!.pet!.media!.isNotEmpty
              ? circularNetworkImageWidget(
                  image: authViewModel.getAuthResponse.data!.pet!.media!,
                  size: 40.h)
              : SizedBox(
                  height: 40.h,
                  width: 40.h,
                  child: CircleAvatar(
                    backgroundColor: CustomColors.yellowColor,
                    child: SvgPicture.asset(dogFace),
                  ),
                ),
        ],
      ),
    );
  });
}
