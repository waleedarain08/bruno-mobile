import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/widgets/web_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/widget_utils.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/user_form_fields_widget.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return WillPopScope(
        onWillPop: () async {
          authViewModel.clearFieldsData();
          authViewModel.getRegisterRouteFrom == Screens.login.text
              ? Navigator.pushReplacementNamed(context, loginRoute)
              : Navigator.pop(context);
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: getIsBiggerThanMobile(context) ? 0.4.sw : null,
                  padding: const EdgeInsets.only(
                          top: 30, bottom: 20, left: 20, right: 20)
                      .w,
                  // child: Stack(
                  //   children: [
                  //     WebCardWidget(
                  //       child: Padding(
                  //         padding: context.isBiggerThanMobile
                  //             ? EdgeInsets.all(20.w)
                  //             : EdgeInsets.zero,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             black24w500Centre(data: 'Let’s get started!'),
                  //             SizedBox(
                  //               height: 10.h,
                  //             ),
                  //             grey14w400(
                  //                 data:
                  //                     'Tell us a bit about you and your pawsome friend'),
                  //             SizedBox(
                  //               height: 32.h,
                  //             ),
                  //             const NameFieldWidget(),
                  //             SizedBox(
                  //               height: 16.h,
                  //             ),
                  //             const EmailFieldWidget(),
                  //             SizedBox(
                  //               height: 16.h,
                  //             ),
                  //             const PhoneFieldWidget(),
                  //             SizedBox(
                  //               height: 16.h,
                  //             ),
                  //             const PasswordFieldWidget(
                  //               hint: 'New Password',
                  //             ),
                  //             SizedBox(
                  //               height: 16.h,
                  //             ),
                  //             const ConfirmPasswordFieldWidget(
                  //               hint: 'Re-Enter New Password',
                  //             ),
                  //             SizedBox(
                  //               height: 40.h,
                  //             ),
                  //             customButton(
                  //                 text: 'Continue',
                  //                 onPressed: () {
                  //                   FocusScopeNode currentFocus =
                  //                       FocusScope.of(context);
                  //
                  //                   if (!currentFocus.hasPrimaryFocus) {
                  //                     currentFocus.unfocus();
                  //                   }
                  //                   if (authViewModel
                  //                       .userRegistrationValidation()) {
                  //                     authViewModel
                  //                         .checkPhoneNumber(checkType: false)
                  //                         .then((value) => {
                  //                               if (!value)
                  //                                 {
                  //                                   Navigator.pushNamed(context,
                  //                                       registerUserContinueRoute)
                  //                                 }
                  //                             });
                  //                   }
                  //                 },
                  //                 colored: true),
                  //             SizedBox(
                  //               height: 20.h,
                  //             ),
                  //             _buildLoginButton(context, authViewModel),
                  //             /* SizedBox(
                  //               height: 20.h,
                  //             ),
                  //             Center(child: grey14w400(data: 'Or continue with')),
                  //             SizedBox(
                  //               height: 20.h,
                  //             ),
                  //             googleFacebookButtonWidget(context: context),*/
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     if (!context.isBiggerThanMobile)
                  //       SizedBox(
                  //         height: screenHeight,
                  //         child: _buildLoginButton(context, authViewModel),
                  //       ),
                  //   ],
                  // ),
                  child: WebCardWidget(
                    child: Padding(
                      padding: context.isBiggerThanMobile
                          ? EdgeInsets.all(20.w)
                          : EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          black24w500Centre(data: 'Let’s get started!'),
                          SizedBox(
                            height: 10.h,
                          ),
                          grey14w400(
                              data:
                                  'Tell us a bit about you and your pawsome friend'),
                          SizedBox(
                            height: 32.h,
                          ),
                          const NameFieldWidget(),
                          SizedBox(
                            height: 16.h,
                          ),
                          const EmailFieldWidget(),
                          SizedBox(
                            height: 16.h,
                          ),
                          const PhoneFieldWidget(),
                          SizedBox(
                            height: 16.h,
                          ),
                          const PasswordFieldWidget(
                            hint: 'New Password',
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          const ConfirmPasswordFieldWidget(
                            hint: 'Re-Enter New Password',
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          customButton(
                              text: 'Continue',
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (authViewModel
                                    .userRegistrationValidation()) {
                                  authViewModel
                                      .checkPhoneNumber(checkType: false)
                                      .then((value) => {
                                            if (!value)
                                              {
                                                Navigator.pushNamed(context,
                                                    registerUserContinueRoute)
                                              }
                                          });
                                }
                              },
                              colored: true),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buildLoginButton(context, authViewModel),
                          /* SizedBox(
                                height: 20.h,
                              ),
                              Center(child: grey14w400(data: 'Or continue with')),
                              SizedBox(
                                height: 20.h,
                              ),
                              googleFacebookButtonWidget(context: context),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Align _buildLoginButton(
    BuildContext context,
    AuthViewModel authViewModel,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          authViewModel.clearFieldsData();
          Navigator.pushReplacementNamed(context, loginRoute);
        },
        child: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Already Have Account? ',
                style: TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 16,
                  fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Log In',
                style: TextStyle(
                  color: CustomColors.orangeColor,
                  fontSize: 16,
                  fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
