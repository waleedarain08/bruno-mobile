import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/images.dart';

class BrunosFooter extends StatelessWidget {
  const BrunosFooter({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return _buildDesktopLayout();
                } else if (constraints.maxWidth > 768) {
                  return _buildTabletLayout();
                } else {
                  return _buildMobileLayout();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            height: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),

          // Bottom Bar
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Section
        Expanded(
          flex: 2,
          child: _buildLogoSection(),
        ),
        const SizedBox(width: 40),

        // Office Address
        Expanded(
          flex: 2,
          child: _buildOfficeAddress(),
        ),
        const SizedBox(width: 40),

        // Customer Service
        Expanded(
          flex: 2,
          child: _buildCustomerService(),
        ),
        const SizedBox(width: 40),

        // Get Started Section
        Expanded(
          flex: 3,
          child: _buildGetStartedSection(),
        ),
        const SizedBox(width: 40),

        // QR Code
        Expanded(
          flex: 2,
          child: _buildQRCode(),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildLogoSection()),
            const SizedBox(width: 30),
            Expanded(child: _buildOfficeAddress()),
            const SizedBox(width: 30),
            Expanded(child: _buildCustomerService()),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildGetStartedSection()),
            const SizedBox(width: 30),
            Expanded(child: _buildQRCode()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoSection(),
        SizedBox(height: 30.h),
        _buildOfficeAddress(),
        SizedBox(height: 30.h),
        _buildCustomerService(),
        SizedBox(height: 30.h),
        _buildGetStartedSection(),
        SizedBox(height: 30.h),
        _buildQRCode(),
      ],
    );
  }

  Widget _buildLogoSection() {
    return SizedBox(
      width: 150.w,
      height: 150.w,
      child: Center(
        child: SvgPicture.asset(logoImage),
      ),
    );
  }

  Widget _buildOfficeAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Office Address',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Bruno's Kitchen LTD\nStore no.17, Tamouh,\nMarina Square, Al Reem Island,\nAbu Dhabi, United Arab Emirates",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerService() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Service',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'If you have any question,\nplease contact us at:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: 16.h),
        InkWell(
          onTap: () => _launchUrl('mailto:hello@brunos.kitchen'),
          child: Row(
            spacing: 8.w,
            children: [
              Icon(
                Icons.email_outlined,
                color: Colors.white70,
                size: 18.sp,
              ),
              Text(
                'hello@brunos.kitchen',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        InkWell(
          onTap: () => _launchUrl('tel:+971585759205'),
          child: Row(
            children: [
              Icon(
                Icons.phone_outlined,
                color: Colors.white70,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                '+971 58 575 9205',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          spacing: 12.w,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () =>
                  _launchUrl('https://www.facebook.com/BrunosKitchenUAE'),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white70,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () =>
                  _launchUrl('https://www.instagram.com/kitchen_bruno'),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white70,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGetStartedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Are you ready to get started?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Give your pooch a taste of luxury with freshly cooked, home-delivered, human-grade meals. Download our app today and serve up happiness!',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: 24.h),
        InkWell(
          onTap: () => _launchUrl(
            'https://play.google.com/store/apps/details?id=com.brunoskitchen.brunos_kitchen',
          ),
          child: Image.asset(
            playstoreBanner,
            height: 50.h,
            width: 170.w,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () => _launchUrl(
            'https://apps.apple.com/us/app/brunos-kitchen/id6474792206',
          ),
          child: Image.asset(
            appstoreBanner,
            height: 50.h,
            width: 170.w,
          ),
        ),
      ],
    );
  }

  Widget _buildQRCode() {
    return Container(
      width: 200.w,
      height: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        footerQr,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.qr_code,
              size: 100,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "© ${DateTime.now().year} – Bruno's Kitchen LTD",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    _buildBottomLink('Privacy Policy',
                        'https://brunos.kitchen/privacy-policy-2/'),
                    const SizedBox(width: 20),
                    _buildBottomLink('Terms and Conditions',
                        'https://brunos.kitchen/terms-and-conditions/'),
                    const SizedBox(width: 20),
                    _buildBottomLink('User Service Agreement',
                        'https://brunos.kitchen/user-service-agreement/'),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Text(
                  "© ${DateTime.now().year} – Bruno's Kitchen LTD",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    _buildBottomLink('Privacy Policy',
                        'https://brunos.kitchen/privacy-policy-2/'),
                    const SizedBox(height: 8),
                    _buildBottomLink('Terms and Conditions',
                        'https://brunos.kitchen/terms-and-conditions/'),
                    const SizedBox(height: 8),
                    _buildBottomLink('User Service Agreement',
                        'https://brunos.kitchen/user-service-agreement/'),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildBottomLink(String text, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
        ),
      ),
    );
  }
}
