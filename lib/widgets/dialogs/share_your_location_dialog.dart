import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../route_generator.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/images.dart';

void shareYourLocationDialog({required BuildContext context}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.5),
/*
    transitionDuration: const Duration(milliseconds: 500),
*/
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 350.h,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(40)),
          child: SizedBox.expand(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  circularMap,
                  width: 150.w,
                ),
                const Spacer(),
                black18w500(data: 'Share Your Address With Us'),
                const Spacer(),
                customButton(
                  height: 40,
                  colored: true,
                  text: 'Continue',
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, addAddressRoute);
                  },
                ),
                const Spacer(),
                customButton(
                  height: 40,
                  colored: false,
                  text: 'Not now',
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )),
        ),
      );
    },
/*
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
*/
  );
}
