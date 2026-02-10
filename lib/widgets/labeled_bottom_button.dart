import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/widget_utils.dart';

class LabeledBottomButton extends StatelessWidget {
  final Widget label;
  final String buttonText;
  final VoidCallback onTap;
  final bool isButtonVisible;

  const LabeledBottomButton({
    super.key,
    required this.label,
    required this.buttonText,
    required this.onTap,
    this.isButtonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: context.isBiggerThanMobile
          ? Alignment.bottomRight
          : Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
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
          child: SizedBox(
            width: context.isBiggerThanMobile ? 0.2.sw : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: context.isBiggerThanMobile
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.center,
              children: [
                label,
                Visibility(
                  visible: isButtonVisible,
                  child: Container(
                    width: context.isBiggerThanMobile ? 0.2.sw : null,
                    padding: const EdgeInsets.only(top: 20.0).w,
                    child: customButton(
                      text: buttonText,
                      onPressed: onTap,
                      colored: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
