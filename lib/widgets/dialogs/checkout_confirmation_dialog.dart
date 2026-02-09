import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../route_generator.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../view_models/auth_view_model.dart';
import '../../view_models/order_view_model.dart';

void checkOutConfirmationDialog({required BuildContext context}) {
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
                  data: 'Do you really want to Place Order?',
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
                          context.read<CartViewModel>().setOrderRequest();
                          context
                              .read<OrderViewModel>()
                              .callCreateOrderApi()
                              .then((value) {
                            if (value) {
                              context.read<CartViewModel>().clearCart();
                              context.read<AuthViewModel>().checkSplash();
                              Navigator.pushNamed(
                                  context, orderConfirmationRoute);
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
