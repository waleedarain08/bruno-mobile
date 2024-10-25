import 'package:brunos_kitchen/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../widgets/back_button_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonWidget(),
                SizedBox(
                  height: 59.h,
                ),
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
                          child: black14w400Centre(
                              data:
                              'We have send an OTP to **********785')),
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
                           // backgroundColor: CustomColors.lightGreyColor,
                          //  controller: authViewModel.getOtpCodeController,
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
                                const EdgeInsets.symmetric(horizontal: 2)),
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
                      const Text.rich(
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
                                color: CustomColors.greyColor,
                                fontSize: 14,
                                fontFamily: 'Circular Std',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 123.9.h,
                      ),
                      customButton(text: 'Continue', onPressed: () {
                        Navigator.pushNamed(context, userVerifiedRoute);
                      }, colored: true),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
