import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update_flutter/in_app_update_flutter.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

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

  Future<Widget> _handleUpdateAndNavigation() async {
    if (!kIsWeb) {
      try {
        if (Platform.isAndroid) {
          final updateInfo = await InAppUpdateFlutter().checkUpdateAndroid();
          if (updateInfo.updateAvailability ==
              UpdateAvailabilityAndroid.updateAvailable) {
            await InAppUpdateFlutter().startImmediateUpdateAndroid();
          }
        } else if (Platform.isIOS) {
          await InAppUpdateFlutter().showUpdateForIos(appStoreId: '6474792206');
        }
      } catch (e) {
        debugPrint('Update check error: $e');
      }
    }
    if (mounted) {
      return context.read<AuthViewModel>().checkSplash();
    }
    return const SizedBox.shrink(); // Fallback
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(splashAnimation),
      logoWidth: 150.78.w,
      backgroundImage: Image.asset(splashBackground).image,
      showLoader: false,
      futureNavigator: _handleUpdateAndNavigation(),
      durationInSeconds: 1,
      loaderColor: CustomColors.orangeColor,
    );
  }
}
