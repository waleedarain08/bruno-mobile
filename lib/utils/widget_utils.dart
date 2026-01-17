import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension WidgetUtils on State {
  bool get isBiggerThanMobile {
    final bool value = !ResponsiveBreakpoints.of(context).isMobile &&
        !ResponsiveBreakpoints.of(context).isTablet;
    log('Is Bigger than Mobile: $value');
    return value;
  }
}

extension StatelessWidgetUtils on StatelessWidget {
  bool getIsBiggerThanMobile(BuildContext context) {
    final bool value = !ResponsiveBreakpoints.of(context).isMobile &&
        !ResponsiveBreakpoints.of(context).isTablet;
    log('Is Bigger than Mobile: $value');
    return value;
  }
}

extension ContextUtils on BuildContext {
  bool get isBiggerThanMobile {
    final bool value = !ResponsiveBreakpoints.of(this).isMobile &&
        !ResponsiveBreakpoints.of(this).isTablet;
    return value;
  }
}
