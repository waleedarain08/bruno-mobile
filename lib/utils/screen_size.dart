// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// Size getDesignSize({required BuildContext context}) {
//   const sizesMap = {
//     'LARGE': Size(1200, 1600),
//     'MEDIUM': Size(768, 1024),
//     'SMALL': Size(600, 900),
//     'DEFAULT': Size(375, 812),
//   };
//   final _ = MediaQuery.sizeOf(context);
//   final window = View.of(context);
//   final size = window.physicalSize / window.devicePixelRatio;
//   late String name;
//   if (size.width >= 1200) {
//     name = 'LARGE';
//   } else if (size.width >= 800) {
//     name = 'MEDIUM';
//   } else if (size.width >= 600) {
//     name = 'SMALL';
//   } else {
//     name = 'DEFAULT';
//   }
//   log('NAME: $name');
//   final appSize = sizesMap[name]!;
//   return size.width > size.height
//       ? Size(appSize.height, appSize.width)
//       : appSize;
// }

import 'package:flutter/cupertino.dart';

Size getDesignSize(BuildContext context, Orientation orientation) {
  final double width = MediaQuery.of(context).size.width;
  final bool isLandscape = orientation == Orientation.landscape;

  // 1. MOBILE & FOLDABLES (Small)
  if (width < 600) {
    if (width < 320) {
      // Tiny/Closed Fold
      return isLandscape ? const Size(882, 344) : const Size(344, 882);
    } else if (width < 390) {
      // Small Phones
      return isLandscape ? const Size(812, 375) : const Size(375, 812);
    } else if (width < 430) {
      // Standard Phones
      return isLandscape ? const Size(844, 390) : const Size(390, 844);
    } else {
      // Large Phones / Phablets
      return isLandscape ? const Size(932, 430) : const Size(430, 932);
    }
  }

  // 2. TABLETS & UNFOLDED FOLDABLES (600px - 1024px)
  if (width < 1024) {
    if (width < 768) {
      // Unfolded Foldables (Z Fold style)
      return isLandscape ? const Size(2176, 1812) : const Size(1812, 2176);
    } else if (width < 840) {
      // Standard Tablets (iPad Mini)
      return isLandscape ? const Size(1024, 768) : const Size(768, 1024);
    } else {
      // Large Tablets (iPad Pro 11)
      return isLandscape ? const Size(1194, 834) : const Size(834, 1194);
    }
  }

  // 3. DESKTOP & WEB (1024px+)
  if (width < 1440) {
    // Laptop / Small Monitor
    return isLandscape ? const Size(1366, 768) : const Size(768, 1366);
  } else if (width < 1920) {
    // HD Desktop
    return isLandscape ? const Size(1440, 900) : const Size(900, 1440);
  } else if (width < 2560) {
    // Full HD
    return isLandscape ? const Size(1920, 1080) : const Size(1080, 1920);
  } else {
    // 4K & Beyond
    return isLandscape ? const Size(3840, 2160) : const Size(2160, 3840);
  }
}
