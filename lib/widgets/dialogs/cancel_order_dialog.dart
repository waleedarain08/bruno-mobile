import 'package:brunos_kitchen/utils/enums.dart';
import 'package:brunos_kitchen/view_models/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';

void cancelOrderDialog({required BuildContext context}) {
  TextEditingController labelText = TextEditingController();
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    //transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return Center(
        child: WillPopScope(
          onWillPop: () async {
            context
                .read<AddressViewModel>()
                .setSelectedLabel(AddressLabels.home.text);
            return true;
          },
          child: Container(
            height: 230.h,
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
                    data: 'Cancel Order',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  black14w500(
                    data: 'Are u sure you want to cancel ?',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customButton(
                    height: 40,
                    colored: true,
                    text: 'Yes',
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customButton(
                    height: 40,
                    colored: false,
                    text: 'Not Now',
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )),
          ),
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
