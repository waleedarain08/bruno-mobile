/*
import 'dart:io';

import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/bottom_navigation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/images.dart';

Widget googleFacebookButtonWidget({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Spacer(),

      InkWell(
        onTap: () {
          context.read<AuthViewModel>().signInWithGoogle().then((value) => {
                if (value)
                  {
                    context
                        .read<BottomNavigationViewModel>()
                        .setHomeViewIndex(0),
                    Navigator.pushNamedAndRemoveUntil(
                        context, bottomNavigationRoute, (route) => false)
                  }
              });
        },
        child: Container(
          width: Platform.isAndroid ? 335.w : null,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: CustomColors.greyShadeColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 11, horizontal: Platform.isAndroid ? 0.0 : 11).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  googleIcon,
                  width: 23,
                  height: 23,
                ),
                Visibility(
                    visible: Platform.isAndroid,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0).w,
                      child: black12w500Centre(data: 'Google'),
                    ))
              ],
            ),
          ),
        ),
      ),
      const Spacer(),
     */
/* InkWell(
        onTap: () {
          context.read<AuthViewModel>().signInWithFacebook().then((value) => {
                if (value)
                  {
                    context
                        .read<BottomNavigationViewModel>()
                        .setHomeViewIndex(0),
                    Navigator.pushNamedAndRemoveUntil(
                        context, bottomNavigationRoute, (route) => false)
                  }
              });
        },
        child: Container(
          width: Platform.isAndroid ? 159.w : null,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: CustomColors.greyShadeColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 11, horizontal: Platform.isAndroid ? 0.0 : 11).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  facebookIcon,
                  width: 23,
                  height: 23,
                ),
                *//*
*/
/*SizedBox(
                  width: 12.w,
                ),*//*
*/
/*
                Visibility(
                    visible: Platform.isAndroid,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0).w,
                      child: black12w500Centre(data: 'Facebook'),
                    ))
              ],
            ),
          ),
        ),
      ),
      const Spacer(),*//*

      Visibility(
        visible: Platform.isIOS,
        child: InkWell(
          onTap: () {
            context.read<AuthViewModel>().signInWithApple().then((value) => {
              if (value)
                {
                  context
                      .read<BottomNavigationViewModel>()
                      .setHomeViewIndex(0),
                  Navigator.pushNamedAndRemoveUntil(
                      context, bottomNavigationRoute, (route) => false)
                }
            });
          },
          child: Container(
            width: Platform.isAndroid ? 159.w : null,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: CustomColors.greyShadeColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 11, horizontal: Platform.isAndroid ? 0.0 : 11).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    appleIcon,
                    width: 23,
                    height: 23,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      const Spacer(),

    ],
  );
}
*/
