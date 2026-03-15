import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/widgets/web_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/widget_utils.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/back_button_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<AuthViewModel>().getOtpController.clear();
      /*context.read<AuthViewModel>().resetTimer();
      await context
          .read<AuthViewModel>()
          .sendingOtp();*/
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

/*    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<AuthViewModel>().stopTimer();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20)
                    .w,
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
                            child: _buildBody(
                              context,
                              authViewModel,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(child: _buildBody(context, authViewModel)),
              ],
            ),
          ),
        ),
      );
    });
  }

  Column _buildBody(BuildContext context, AuthViewModel authViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              SvgPicture.asset(
                password,
                width: 199.w,
              ),
              SizedBox(
                height: 22.h,
              ),
              black24w500Centre(data: 'OTP Verification'),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                  width: 306.57.w,
                  child: lightBlack14w400Centre(
                      data:
                          'We have send an OTP to ${authViewModel.getEmailController.text}')),
              SizedBox(
                height: 26.h,
              ),
              Form(
                // key: formKey,
                child: SizedBox(
                  width: 250.w,
                  child: PinCodeTextField(
                    // errorAnimationController: errorController,
                    keyboardType: TextInputType.number,
                    autoDisposeControllers: false,
                    // backgroundColor: CustomColors.lightGreyColor,
                    controller: authViewModel.getOtpController,
                    appContext: context,
                    length: 4,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        fieldHeight: 60.w,
                        fieldWidth: 46.w,
                        inactiveColor: CustomColors.greyMediumLightColor,
                        selectedColor: CustomColors.greyMediumLightColor,
                        activeColor: CustomColors.greyMediumLightColor,
                        activeFillColor: CustomColors.greyMediumLightColor,
                        selectedFillColor: CustomColors.greyMediumLightColor,
                        inactiveFillColor: CustomColors.greyMediumLightColor,
                        fieldOuterPadding:
                            const EdgeInsets.symmetric(horizontal: 2).w),
                    enableActiveFill: true,
                    pastedTextStyle: const TextStyle(
                      //    color: CustomColors.color1,
                      fontWeight: FontWeight.bold,
                    ),
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black45,
                        blurRadius: 5,
                      )
                    ],
                    onCompleted: (value) {
                      debugPrint(value);
                      /*  setState(() {
                                          currentText = value;
                                        });*/
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    onChanged: (String value) {},
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Visibility(
                  visible: authViewModel.getOtpMinutes != '00' ||
                      authViewModel.getOtpSeconds != '00',
                  child: lightBlack14w400Centre(
                      data:
                          'OTP will expire in ${authViewModel.getOtpMinutes}:${authViewModel.getOtpSeconds}')),
              Visibility(
                visible: (authViewModel.getOtpMinutes == '00' &&
                    authViewModel.getOtpSeconds == '00'),
                child: InkWell(
                  onTap: () {
                    context.read<AuthViewModel>().sendingOtp();
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Didn’t Receive Code? ',
                          style: TextStyle(
                            color: CustomColors.greyColor,
                            fontSize: 14,
                            fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Resend again',
                          style: TextStyle(
                            color: CustomColors.orangeColor,
                            fontSize: 14,
                            fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Visibility(
          visible: authViewModel.getOtpController.value.text.length == 4,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: customButton(
                text: 'Continue',
                onPressed: () {
                  if (authViewModel.getOtpRouteFrom ==
                      Screens.forgetPassword.text) {
                    authViewModel.verifyingOtp().then((value) {
                      if (value) {
                        Navigator.pushNamed(context, resetPasswordRoute);
                      }
                    });
                  } else {
                    authViewModel.callUserRegisterApi().then((value) => {
                          if (value)
                            {Navigator.pushNamed(context, userVerifiedRoute)}
                        });
                  }
                },
                colored: true),
          ),
        ),
      ],
    );
  }
}
