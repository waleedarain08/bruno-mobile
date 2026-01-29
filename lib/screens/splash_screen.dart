import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../services/local_notification_service.dart';
import '../utils/custom_colors.dart';
import '../utils/images.dart';
import '../view_models/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(splashAnimation),
      logoWidth: 150.78.w,
      backgroundImage: Image.asset(splashBackground).image,
      showLoader: false,
      futureNavigator: context.read<AuthViewModel>().checkSplash(),
      durationInSeconds: 1,
      loaderColor: CustomColors.orangeColor,
    );
  }
}
