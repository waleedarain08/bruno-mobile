import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../view_models/address_view_model.dart';
import '../view_models/auth_view_model.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final address = context
            .watch<AuthViewModel>()
            .getAuthResponse
            .data!
            .location
            ?.address ??
        'Tap to set Your Location';
    return InkWell(
      onTap: () {
        if (kIsWeb) {
          return;
        }
        context.read<AddressViewModel>().setRouteFromHome(true);
        if (context.read<AuthViewModel>().getAuthResponse.data!.location !=
            null) {
          Navigator.pushNamed(context, addressRoute);
        } else {
          context.read<AddressViewModel>().setIsAddressAdd(true);
          Navigator.pushNamed(context, addAddressRoute);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (context.isBiggerThanMobile)
                yellow10w500(data: 'LOCATION')
              else
                purple10w500Centre(data: 'LOCATION'),
              Icon(
                Icons.keyboard_arrow_down,
                color: context.isBiggerThanMobile
                    ? CustomColors.yellowColor
                    : CustomColors.purpleColor,
              )
            ],
          ),
          SizedBox(
            width: 260.w,
            child: context.isBiggerThanMobile
                ? white12w400(data: address)
                : lightBlack14w400Centre(data: address, left: true),
          )
        ],
      ),
    );
  }
}
