import 'package:flutter/cupertino.dart';

enum DeviceType { foldOuter, mobile, tablet, desktop }

Size getDesignSize(BoxConstraints constraints, Orientation orientation) {
  final double width = constraints.maxWidth;
  final bool isLandscape = orientation == Orientation.landscape;

  // Determine device type based on screen width
  DeviceType deviceType;
  if (width < 500) {
    deviceType = DeviceType.foldOuter;
  } else if (width < 600) {
    deviceType = DeviceType.mobile;
  } else if (width < 1024) {
    deviceType = DeviceType.tablet;
  } else {
    deviceType = DeviceType.desktop;
  }

  // Use switch-like structure to return appropriate design size
  switch (deviceType) {
    case DeviceType.foldOuter:
      // Samsung Fold Outer Screen: Size(344, 882)
      return isLandscape ? const Size(882, 360) : const Size(360, 882);
    case DeviceType.mobile:
      // Mobile: Size(360, 690)
      return isLandscape ? const Size(812, 375) : Size(375, 812);

    case DeviceType.tablet:
      // Tablet/Foldable (Unfolded): Size(768, 1024)
      return isLandscape ? const Size(1024, 768) : const Size(768, 1024);

    case DeviceType.desktop:
      // Desktop: Size(1440, 800)
      return isLandscape ? const Size(1440, 800) : const Size(800, 1440);
  }
}
