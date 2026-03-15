import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/widgets/web_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_font_style.dart';
import '../utils/widget_utils.dart';
import '../widgets/back_button_widget.dart';

class UserVerifiedScreen extends StatelessWidget {
  const UserVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonWidget(),
              SizedBox(
                height: 59.h,
              ),
              if (context.isBiggerThanMobile)
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: context.isBiggerThanMobile ? 0.4.sw : null,
                      child: WebCardWidget(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: _buildBody(context),
                        ),
                      ),
                    ),
                  ),
                )
              else
                Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          tick,
          width: 108.w,
        ),
        SizedBox(
          height: 31.h,
        ),
        black24w500Centre(data: 'Congratulations!'),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
            width: 306.57.w,
            child:
                lightBlack14w400Centre(data: 'Your account has been verified')),
        if (context.isBiggerThanMobile) SizedBox(height: 30.h) else Spacer(),
        customButton(
          text: 'Continue',
          onPressed: () {
            Navigator.pushNamed(context, pawPointsRoute);
          },
          colored: true,
        ),
      ],
    );
  }
}
