import 'dart:async';

import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/responses/auth_response.dart';
import '../../utils/custom_colors.dart';

void homePromoDialog(
    {required BuildContext context, required Greetings greetingData}) {
  Timer? timer = Timer(const Duration(milliseconds: 10000), () {
    Navigator.of(context, rootNavigator: true).pop();
  });
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
/*
    transitionDuration: const Duration(milliseconds: 500),
*/
    pageBuilder: (context, __, ___) {
      return Center(
        child: Container(
          height: context.isBiggerThanMobile ? 600.h : 450.h,
          width: context.isBiggerThanMobile
              ? MediaQuery.widthOf(context) * 0.5
              : null,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(40)),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: CustomColors.blackColor,
                        size: 30.h,
                      ))),
              SizedBox.expand(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      greetingData.media![0],
                      //  width: 150.w,

                      height: context.isBiggerThanMobile ? 530.h : 400.h,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          height: 400.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      // fit: BoxFit.fitWidth,
                    ),
                    //  const Spacer(),
                    // black18w500(data: 'Share Your Address With Us'),
                    //   const Spacer(),
                    /*customButton(
                          height: 40,
                          colored: true,
                          text: 'Continue',
                          onPressed: () async {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, addAddressRoute);
                          },
                        ),
                        const Spacer(),*/
                    /* customButton(
                          height: 40,
                          colored: false,
                          text: 'Not now',
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),*/
                  ],
                ),
              )),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    timer!.cancel();
    timer = null;
  });
}
