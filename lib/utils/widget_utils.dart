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

  bool get isTablet {
    log('TABLET: ${ResponsiveBreakpoints.of(this).breakpoint.name}');
    return ResponsiveBreakpoints.of(this).isTablet;
  }

  double? get webSize {
    return isBiggerThanMobile ? MediaQuery.widthOf(this) * 0.4 : null;
  }
}
