import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/enums.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/widgets/user_form_fields_widget.dart';
import 'package:brunos_kitchen/widgets/web_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../widgets/back_button_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
              left: 20,
              right: 20,
            ).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonWidget(),
                _buildBody(context, authViewModel)
              ],
            ),
          ),
        ),
      );
    });
  }

  Center _buildBody(BuildContext context, AuthViewModel authViewModel) {
    return Center(
      child: SizedBox(
        width: context.isBiggerThanMobile ? 0.4.sw : null,
        child: WebCardWidget(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                black24w500Centre(data: 'Forget Password'),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: 286.w,
                  child: grey14w400(
                      data:
                          'We will send you a confirmation code to your email for password reset'),
                ),
                SizedBox(
                  height: 32.h,
                ),
                const EmailFieldWidget(),
                SizedBox(
                  height: 40.h,
                ),
                customButton(
                  text: 'Continue',
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (authViewModel.emailValidation()) {
                      await authViewModel.checkEmail().then((value) async {
                        if (value) {
                          authViewModel
                              .setOtpType(OtpTypes.forgotPassword.text);
                          await authViewModel.sendingOtp().then((value) {
                            if (value) {
                              Navigator.pushNamed(context, otpRoute);
                            }
                          });
                        }
                      });
                    }
                  },
                  colored: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
