import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/images.dart';
import '../view_models/auth_view_model.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: authViewModel.getPhoneController,
            onChanged: (text) {},
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hintText: 'Phone Number',
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(phoneIcon),
                        CountryCodePicker(
                          padding: EdgeInsets.zero,
                          showFlagMain: false,
                          onChanged: (value) =>
                              {authViewModel.setCountryCode(value.toString())},
                          initialSelection: authViewModel.getCountryCode,
                          favorite: const ['+971', 'UAE'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          textStyle: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 14.sp,
                            color: CustomColors.greyColor,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: VerticalDivider(
                            color: CustomColors.greyShadeColor,
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
            visible: authViewModel.getPhoneFieldError.isNotEmpty,
            child: orange14w400(
              data: authViewModel.getPhoneFieldError,
            ),
          ),
        ],
      );
    });
  }
}

class NameFieldWidget extends StatelessWidget {
  const NameFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: authViewModel.getNameController,
            onChanged: (text) {},
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: 'Full Name',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset(userIcon),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
              visible: authViewModel.getNameFieldError.isNotEmpty,
              child: orange14w400(data: authViewModel.getNameFieldError)),
        ],
      );
    });
  }
}

class EmailFieldWidget extends StatelessWidget {
  const EmailFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: authViewModel.getEmailController,
            onChanged: (text) {},
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Email Address',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset(emailIcon),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
              visible: authViewModel.getEmailFieldError.isNotEmpty,
              child: orange14w400(data: authViewModel.getEmailFieldError)),
        ],
      );
    });
  }
}

class PasswordFieldWidget extends StatelessWidget {
  final String hint;

  const PasswordFieldWidget({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: authViewModel.getPasswordController,
            onChanged: (text) {},
            obscureText: authViewModel.getSecurePassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: authViewModel.getSecurePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  authViewModel.setSecurePassword();
                },
              ),
              hintText: hint,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(lockIcon),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
            visible: authViewModel.getPasswordFieldError.isNotEmpty,
            child: orange14w400(
              data: authViewModel.getPasswordFieldError,
            ),
          ),
        ],
      );
    });
  }
}

class ConfirmPasswordFieldWidget extends StatelessWidget {
  final String hint;

  const ConfirmPasswordFieldWidget({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: authViewModel.getConfirmPasswordController,
            onChanged: (text) {},
            obscureText: authViewModel.getSecurePassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                hintText: hint,
                suffixIcon: IconButton(
                  icon: authViewModel.getSecurePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    authViewModel.setSecurePassword();
                  },
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset(lockIcon),
                )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
              visible: authViewModel.getConfirmPasswordFieldError.isNotEmpty,
              child: orange14w400(
                  data: authViewModel.getConfirmPasswordFieldError)),
        ],
      );
    });
  }
}
