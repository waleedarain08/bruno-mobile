// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/widget_utils.dart';
import '../view_models/bottom_navigation_view_model.dart';

class CustomBottomBarWidget extends StatefulWidget {
  const CustomBottomBarWidget({super.key});

  @override
  _CustomBottomBarWidgetState createState() => _CustomBottomBarWidgetState();
}

class _CustomBottomBarWidgetState extends State<CustomBottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),

        // color: AppTheme.primaryColor.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      height: isBiggerThanMobile ? 90.h : 70.h,
      width: MediaQuery.of(context).size.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: const Material(
          type: MaterialType.transparency,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BBarIcon(
                title: "Home",
                iconData: Icons.home_filled,
                selectedIcon: Icons.home_filled,
                index: 0,
              ),
              BBarIcon(
                title: "Shop",
                iconData: Icons.shopping_bag,
                selectedIcon: Icons.shopping_bag,
                index: 1,
              ),
              BBarIcon(
                title: "Profile",
                iconData: Icons.account_circle,
                selectedIcon: Icons.account_circle,
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BBarIcon extends StatefulWidget {
  final int index;
  final String title;
  final IconData iconData;
  final IconData selectedIcon;

  const BBarIcon({
    super.key,
    required this.title,
    required this.iconData,
    required this.selectedIcon,
    required this.index,
  });
  @override
  _BBarIconState createState() => _BBarIconState();
}

class _BBarIconState extends State<BBarIcon> {
  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: isBiggerThanMobile ? 70.h : 65.h,
      child: Consumer<BottomNavigationViewModel>(
        builder: (context, bottomNavigationViewModel, _) {
          return InkResponse(
            onTap: () {
              bottomNavigationViewModel.setHomeViewIndex(widget.index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child:
                      widget.index == bottomNavigationViewModel.getHomeViewIndex
                          ? Icon(
                              widget.selectedIcon,
                              key: const Key("selected"),
                              color: CustomColors.orangeColor,
                              size: 28,
                            )
                          : Icon(
                              widget.iconData,
                              key: const Key("unselected"),
                              color: CustomColors.greyColor,
                              // color: AppTheme.lightGreyColor,
                              size: 28,
                            ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.index ==
                            bottomNavigationViewModel.getHomeViewIndex
                        ? CustomColors.orangeColor
                        : CustomColors.greyColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
