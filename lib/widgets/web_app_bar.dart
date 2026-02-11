import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/custom_colors.dart';
import '../utils/images.dart';
import 'location_widget.dart';

class WebAppBar extends StatelessWidget {
  final Widget child;
  const WebAppBar({super.key, required this.child});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }
    return Column(
      children: [
        Container(
          color: CustomColors.orangeColor,
          padding: EdgeInsets.symmetric(
            horizontal: 0.03.sw,
            vertical: 10.h,
          ),
          child: Row(
            spacing: 20.w,
            children: [
              SvgPicture.asset(
                logoImage,
                width: 75.w,
                height: 75.w,
              ),
              Expanded(child: LocationWidget()),
              if (context.isBiggerThanMobile)
                Column(
                  spacing: 10.h,
                  children: [
                    white12w400(
                      data: 'Download our APP and serve up happiness!',
                    ),
                    Row(
                      spacing: 30.w,
                      children: [
                        InkWell(
                          onTap: () => _launchUrl(
                            'https://play.google.com/store/apps/details?id=com.brunoskitchen.brunos_kitchen',
                          ),
                          child: Image.asset(
                            height: 40.h,
                            playstoreBanner,
                          ),
                        ),
                        InkWell(
                          onTap: () => _launchUrl(
                            'https://apps.apple.com/us/app/brunos-kitchen/id6474792206',
                          ),
                          child: Image.asset(
                            height: 40.h,
                            appstoreBanner,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
