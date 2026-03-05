import 'package:brunos_kitchen/models/address_model.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/enums.dart';
import 'package:brunos_kitchen/view_models/address_view_model.dart';
import 'package:brunos_kitchen/view_models/bottom_navigation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/images.dart';
import '../../view_models/auth_view_model.dart';

Widget addressVerticalListChipWidget({required AddressModel addressDetail}) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          if (navigatorKey.currentContext!
                  .read<BottomNavigationViewModel>()
                  .getHomeViewIndex !=
              2) {
            if (navigatorKey.currentContext!
                .read<AddressViewModel>()
                .getRouteFromHome){
              Navigator.pop(navigatorKey.currentContext!);
            }
            else{
              Navigator.pop(navigatorKey.currentContext!);
              Navigator.pop(navigatorKey.currentContext!);
              Navigator.pushNamed(navigatorKey.currentContext!, checkOutRoute);
            }
              navigatorKey.currentContext!
                  .read<AuthViewModel>()
                  .setAddress(addressDetail);

          } else {
            navigatorKey.currentContext!
                .read<AddressViewModel>()
                .setIsAddressAdd(false);
            navigatorKey.currentContext!
                .read<AddressViewModel>()
                .setEditAddress(value: addressDetail);
            Navigator.pushNamed(
                navigatorKey.currentContext!, addressDetailRoute);
          }
        },
        child: Container(
          decoration: ShapeDecoration(
            color: CustomColors.lightGreyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1, color: CustomColors.orangeColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          addressDetail.label == AddressLabels.home.text
                              ? homeAddressIcon
                              : addressDetail.label == AddressLabels.work.text
                                  ? workAddressIcon
                                  : addressDetail.label ==
                                          AddressLabels.partner.text
                                      ? partnerAddressIcon
                                      : otherAddressIcon,
                          width: 15.w,
                          color: CustomColors.orangeColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    black12w500Centre(
                      data: addressDetail.label == AddressLabels.home.text
                          ? AddressLabels.home.text
                          : addressDetail.label == AddressLabels.work.text
                              ? AddressLabels.work.text
                              : addressDetail.label ==
                                      AddressLabels.partner.text
                                  ? AddressLabels.partner.text
                                  : addressDetail.label!,
                    ),
                    const Spacer(),
                    Visibility(
                      visible: addressDetail.isDefault!,
                      child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: CustomColors.orangeColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2),
                            child: white12w400(data: 'Default'),
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          black14w500(data: addressDetail.address!),
                          SizedBox(
                            height: 5.h,
                          ),
                          grey14w400(
                              data:
                                  'Building Name/No: ${addressDetail.flatHouseNumber!}'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigatorKey.currentContext!
                            .read<AddressViewModel>()
                            .setIsAddressAdd(false);
                        navigatorKey.currentContext!
                            .read<AddressViewModel>()
                            .setEditAddress(value: addressDetail);
                        Navigator.pushNamed(
                            navigatorKey.currentContext!, addressDetailRoute);
                        /* navigatorKey.currentContext!.read<AddressViewModel>().setIsAddressAdd(false);
                        Navigator.pushNamed(
                            navigatorKey.currentContext!, addAddressRoute);*/
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          color: CustomColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.75,
                                color: CustomColors.greyMediumColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.sticky_note_2_outlined,
                            size: 20,
                            color: CustomColors.orangeColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
    ],
  );
}
