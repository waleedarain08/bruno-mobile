import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_colors.dart';
import 'cart_icon_widget.dart';
import 'deafult_puppy_icon_widget.dart';

class AppBarWithBackWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? heading;
  final bool showPuppy;
  final bool showCart;
  final Function? onBackPress;

  const AppBarWithBackWidget(
      {super.key,
      this.heading,
      required this.showPuppy,
      required this.showCart,
      this.onBackPress});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: context.isBiggerThanMobile ? 80.h : 60.h,
      backgroundColor: context.isBiggerThanMobile
          ? Theme.of(context).scaffoldBackgroundColor
          : CustomColors.whiteColor,
      elevation: context.isBiggerThanMobile ? 0 : 1,
      scrolledUnderElevation: 0,
      title: heading != null ? Text(heading!) : SizedBox.shrink(),
      leading: InkWell(
        onTap: () {
          onBackPress != null ? onBackPress!() : Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: CustomColors.blackColor,
          ),
        ),
      ),
      actionsPadding: context.isBiggerThanMobile
          ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h)
          : null,
      actions: [
        Visibility(
          visible: showCart,
          child: Padding(
            padding: context.isBiggerThanMobile
                ? EdgeInsets.zero
                : EdgeInsets.only(right: showPuppy ? 10.w : 20.w, top: 10.h),
            child: cartIconWidget(),
          ),
        ),
        if (context.isBiggerThanMobile)
          SizedBox(
            width: 20.w,
          ),
        Visibility(
          visible: showPuppy,
          child: Padding(
            padding: EdgeInsets.only(right: 10.w, top: 10.h),
            child: defaultPuppyIconWidget(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
      navigatorKey.currentContext!.isBiggerThanMobile ? 80.h : 60.h,
    );
  }
}
