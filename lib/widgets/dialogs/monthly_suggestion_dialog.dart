import 'package:brunos_kitchen/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/custom_buttons.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';

void monthlySuggestionDialog({required BuildContext context}) {
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
                  const Spacer(),
                  black18w500(
                      data:
                          'Want a more convenient and cost-effective option?'),
                  const Spacer(),
                  lightBlack14w400Centre(
                      data:
                          'Why not try the monthly plan instead where you get to choose up to 3 recipes for a whole month at a discounted price. We prepare and portion the food for you for a hassle-free feeding experience'),
                  const Spacer(),
                  customButton(
                    height: 40,
                    colored: true,
                    text: 'Take me to the monthly meal option',
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, monthlyPlanRoute);
                    },
                  ),
                  const Spacer(),
                  customButton(
                    height: 40,
                    colored: false,
                    text: 'No thanks !',
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )),
          ),
        );
      });
}
