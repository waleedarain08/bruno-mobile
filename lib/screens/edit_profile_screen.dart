import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/widgets/app_bar_with_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/custom_buttons.dart';
import '../utils/images.dart';
import '../widgets/user_form_fields_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWithBackWidget(
            heading: 'Edit Profile', showPuppy: false, showCart: true),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20)
                    .w,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NameFieldWidget(),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextField(
                      controller:
                          context.watch<AuthViewModel>().getEmailController,
                      onChanged: (text) {},
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SvgPicture.asset(emailIcon),
                          )),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    /*const EmailFieldWidget(),
                    SizedBox(
                      height: 16.h,
                    ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller:
                              context.watch<AuthViewModel>().getPhoneController,
                          onChanged: (text) {},
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: IntrinsicHeight(
                                child: SvgPicture.asset(phoneIcon),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Visibility(
                            visible: context
                                .watch<AuthViewModel>()
                                .getPhoneFieldError
                                .isNotEmpty,
                            child: orange14w400(
                                data: context
                                    .watch<AuthViewModel>()
                                    .getPhoneFieldError)),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeightWithAppBar,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: customButton(
                        text: 'Save',
                        onPressed: () {
                          context
                              .read<AuthViewModel>()
                              .editUserProfileApi()
                              .then((value) => {
                                    if (value) {Navigator.pop(context)}
                                  });
                        },
                        colored: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
