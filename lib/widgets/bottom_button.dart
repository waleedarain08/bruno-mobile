import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/widget_utils.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? visible;
  const BottomButton(
      {super.key, required this.title, required this.onTap, this.visible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? MediaQuery.of(context).viewInsets.bottom == 0,
      child: Align(
        alignment: context.isBiggerThanMobile
            ? Alignment.bottomRight
            : Alignment.bottomCenter,
        child: Container(
          width: context.isBiggerThanMobile ? 0.2.sw : null,
          decoration: context.isBiggerThanMobile
              ? null
              : const BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 2,
                      color: Colors.black12,
                    ),
                  ],
                ),
          child: Padding(
            padding: const EdgeInsets.all(20).w,
            child: customButton(
              text: title,
              onPressed: onTap,
              colored: true,
            ),
          ),
        ),
      ),
    );
  }
}
