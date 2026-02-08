import 'dart:developer';

import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import '../utils/custom_colors.dart';
import '../utils/images.dart';
import 'location_widget.dart';

class WebAppBar extends StatelessWidget {
  final Widget child;
  const WebAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: splashNotifier,
      builder: (_, show, __) {
        log('VALUE: ${!context.isBiggerThanMobile} $show');
        if (!context.isBiggerThanMobile || !show) {
          return child;
        }
        return Column(
          children: [
            Container(
              color: CustomColors.orangeColor,
              padding: EdgeInsets.symmetric(
                horizontal: 0.03.sw,
                vertical: 10.h,
              ),
              child: Row(
                spacing: 20.w,
                children: [
                  SvgPicture.asset(
                    logoImage,
                    width: 75.w,
                    height: 75.w,
                  ),
                  LocationWidget(),
                  Spacer(),
                  Column(
                    spacing: 10.h,
                    children: [
                      white12w400(
                        data: 'Download our APP and serve up happiness!',
                      ),
                      Row(
                        spacing: 30.w,
                        children: [
                          Image.asset(
                            height: 40.h,
                            playstoreBanner,
                          ),
                          Image.asset(
                            height: 40.h,
                            appstoreBanner,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
