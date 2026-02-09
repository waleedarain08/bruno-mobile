import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth_view_model.dart';

void deletePetConfirmationDialog(
    {required BuildContext context, required String name}) {
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
          height: 170.h,
          width: context.isBiggerThanMobile
              ? MediaQuery.widthOf(context) * 0.4
              : null,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(40)),
          child: SizedBox.expand(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                black18w500(
                  data: 'Confirmation',
                ),
                const Spacer(),
                lightBlack14w400Centre(
                  data: 'Do you really want to Delete $name?',
                ),
                const Spacer(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: customButton(
                        height: 40,
                        colored: false,
                        text: 'No',
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: customButton(
                        height: 40,
                        colored: true,
                        text: 'Yes',
                        onPressed: () async {
                          Navigator.pop(context);
                          await context
                              .read<PuppyViewModel>()
                              .callDeletePuppyApi()
                              .then((value) => {
                                    if (value)
                                      {
                                        Navigator.pop(context),
                                        context
                                            .read<AuthViewModel>()
                                            .callSplash(showLoader: true)
                                      }
                                  });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      );
    },
    /*transitionBuilder: (_, anim, __, child) {
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
    },*/
  );
}
