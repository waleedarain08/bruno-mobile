
import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/enums.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/google_facebook_button_widget.dart';
import '../widgets/user_form_fields_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20).w,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      black24w500Centre(data: 'Welcome back Dog Lovers ❤️'),
                      SizedBox(
                        height: 10.h,
                      ),
                      grey14w400(data: 'Please enter your login details below'),
                      SizedBox(
                        height: 32.h,
                      ),
                      const EmailFieldWidget(),
                      SizedBox(
                        height: 16.h,
                      ),
                      const PasswordFieldWidget(hint: 'Password',),
                      SizedBox(
                        height: 12.h,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: (){
                                authViewModel.clearFieldsData();
                                context.read<AuthViewModel>().setOtpRouteFrom(Screens.forgetPassword.text);
                                Navigator.pushNamed(context, forgetPasswordRoute);
                              },
                              child: orange14w400(data: 'Forget Password ?'))),
                      SizedBox(
                        height: 40.h,
                      ),
                      customButton(text: 'Login', onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                            if (authViewModel.signInValidation()) {
                              authViewModel.callSignInApi().then((value) => {
                                    if (value)
                                      {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            bottomNavigationRoute,
                                            (route) => false)
                                      }
                                  });
                            }
                          }, colored: true),
                     /* SizedBox(
                        height: 20.h,
                      ),
                      Center(child: grey14w400(data: 'Or continue with')),
                      SizedBox(
                        height: 20.h,
                      ),
                      googleFacebookButtonWidget(context: context),*/
                      SizedBox(
                        height: 40.h,
                      ),
                      customButton(text: 'Continue As Guest', onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        authViewModel.callGuestUserRegisterApi().then((value) => {
                          if (value)
                            {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  bottomNavigationRoute, (route) => false)
                            }
                        });
                      }, colored: false),


                    ],
                  ),
                  SizedBox(
                    height: screenHeight-50,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          authViewModel.clearFieldsData();
                          authViewModel.setOtpRouteFrom(Screens.registerUser.text);
                          context.read<AuthViewModel>().setRegisterRouteFrom(Screens.login.text);
                          Navigator.pushReplacementNamed(context,registerUserRoute);
                        },
                        child: const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don’t Have Account? ',
                                style: TextStyle(
                                  color: CustomColors.blackColor,
                                  fontSize: 16,
                                  fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
