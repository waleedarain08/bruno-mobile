import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_font_style.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/bottom_navigation_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBar: const AppBarWithBackWidget(
          heading: 'Delete Account',
          showPuppy: false,
          showCart: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20).w,
          child: WebSizedBox(
            child: Column(
              children: [
                black16w500(
                    data:
                        'This will delete your account permanently. You will not be able to retrieve your data unless you log in again in the next 10 days.'),
                SizedBox(
                  height: 20.h,
                ),
                customButton(
                    text: 'Delete Now',
                    onPressed: () {
                      context.read<AuthViewModel>().clearFieldsData();
                      context
                          .read<BottomNavigationViewModel>()
                          .setHomeViewIndex(0);
                      context.read<AuthViewModel>().callLogOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, loginRoute, (route) => false);
                    },
                    colored: true),
                SizedBox(
                  height: 20.h,
                ),
                black16w500(data: 'OR'),
                SizedBox(
                  height: 20.h,
                ),
                customButton(
                    text: 'Contact Support', onPressed: () {}, colored: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
