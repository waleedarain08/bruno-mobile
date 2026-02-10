import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class WebCardWidget extends StatelessWidget {
  final Widget child;

  const WebCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!context.isBiggerThanMobile) {
      return child;
    }
    return Card(
      color: CustomColors.whiteColor,
      elevation: 10,
      child: child,
    );
  }
}
