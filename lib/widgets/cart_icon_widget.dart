import 'package:badges/badges.dart' as badges;
import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_colors.dart';
import '../utils/images.dart';
import '../utils/widget_utils.dart';

Widget cartIconWidget() {
  return Consumer<CartViewModel>(builder: (_, cartViewModel, __) {
    return Center(
      child: badges.Badge(
        badgeStyle: const badges.BadgeStyle(
          badgeColor: CustomColors.orangeColor,
        ),
        badgeContent: Text(
          cartViewModel.getCartList.length.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        child: SizedBox(
          height: navigatorKey.currentContext!.isBiggerThanMobile ? 40.h : 30.h,
          width: navigatorKey.currentContext!.isBiggerThanMobile ? 40.h : 30.h,
          child: InkWell(
            onTap: () {
              if (kDebugMode) {
                Navigator.pushNamed(navigatorKey.currentContext!, cartRoute);
              }
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.purpleColorTint,
              child: SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: SvgPicture.asset(
                    shoppingBagIcon,
                    color: CustomColors.whiteColor,
                  )),
            ),
          ),
        ),
      ),
    );
  });
}
