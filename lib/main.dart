import 'package:brunos_kitchen/firebase_options.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/utils/screen_size.dart';
import 'package:brunos_kitchen/view_models/address_view_model.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:brunos_kitchen/view_models/bottom_navigation_view_model.dart';
import 'package:brunos_kitchen/view_models/card_view_model.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:brunos_kitchen/view_models/faqs_blogs_news_view_model.dart';
import 'package:brunos_kitchen/view_models/order_view_model.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = CustomColors.orangeColor
    ..backgroundColor = CustomColors.whiteColor
    ..indicatorColor = CustomColors.orangeColor
    ..textColor = CustomColors.orangeColor
    ..maskColor = Colors.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

/*//TODO: LOCAL NOTIFICATION
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  */ /*'This channel is used for important notifications.',*/ /* // description
  importance: Importance.max,
);*/

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final double screenHeight =
    MediaQuery.of(navigatorKey.currentContext!).size.height * 0.9;
final double screenHeightWithAppBar =
    MediaQuery.of(navigatorKey.currentContext!).size.height * 0.8;

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

Future<void> main() async {
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.amber, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icon color
    systemNavigationBarIconBrightness:
        Brightness.dark, // color of navigation controls
  ));
  // Stripe.publishableKey =
  //     "pk_live_51O6BroGm97cexwqwVYot0mnw9MgdK1qBOCTJ35dxF6582pfptbKcHGsnZbfDR7CbtlR6YxayCNiuArS3DWOvNGH300JR8PSnHM";
  configLoading();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => BottomNavigationViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => PuppyViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => PlansViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => AddressViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => FaqsBlogsNewsViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => CardViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

Future backgroundHandler(RemoteMessage msg) async {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: getDesignSize(context: context),
        //useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            supportedLocales: const [
              Locale("af"),
              Locale("am"),
              Locale("ar"),
              Locale("az"),
              Locale("be"),
              Locale("bg"),
              Locale("bn"),
              Locale("bs"),
              Locale("ca"),
              Locale("cs"),
              Locale("da"),
              Locale("de"),
              Locale("el"),
              Locale("en"),
              Locale("es"),
              Locale("et"),
              Locale("fa"),
              Locale("fi"),
              Locale("fr"),
              Locale("gl"),
              Locale("ha"),
              Locale("he"),
              Locale("hi"),
              Locale("hr"),
              Locale("hu"),
              Locale("hy"),
              Locale("id"),
              Locale("is"),
              Locale("it"),
              Locale("ja"),
              Locale("ka"),
              Locale("kk"),
              Locale("km"),
              Locale("ko"),
              Locale("ku"),
              Locale("ky"),
              Locale("lt"),
              Locale("lv"),
              Locale("mk"),
              Locale("ml"),
              Locale("mn"),
              Locale("ms"),
              Locale("nb"),
              Locale("nl"),
              Locale("nn"),
              Locale("no"),
              Locale("pl"),
              Locale("ps"),
              Locale("pt"),
              Locale("ro"),
              Locale("ru"),
              Locale("sd"),
              Locale("sk"),
              Locale("sl"),
              Locale("so"),
              Locale("sq"),
              Locale("sr"),
              Locale("sv"),
              Locale("ta"),
              Locale("tg"),
              Locale("th"),
              Locale("tk"),
              Locale("tr"),
              Locale("tt"),
              Locale("uk"),
              Locale("ug"),
              Locale("ur"),
              Locale("uz"),
              Locale("vi"),
              Locale("zh")
            ],
            localizationsDelegates: const [
              CountryLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            /*  localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,*/
            theme: ThemeData(
              scaffoldBackgroundColor: CustomColors.whiteColor,
              primaryColor: CustomColors.whiteColor,
              colorScheme: ThemeData().colorScheme.copyWith(
                    secondary: CustomColors.whiteColor,
                    primary: CustomColors.orangeColor,
                  ),
              appBarTheme: AppBarTheme(
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.blackColor,
                  )),
              textTheme: TextTheme(
                titleMedium: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 14.sp,
                  color:
                      CustomColors.blackColor, // <-- TextFormField input color
                ),
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: CustomColors.orangeColor, //<-- SEE HERE
              ),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                fillColor: CustomColors.lightGreyColor,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                suffixIconColor: CustomColors.greyColor,
                prefixIconColor: CustomColors.greyColor,
                focusColor: CustomColors.orangeColor,
                hintStyle: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 14.sp,
                  color: CustomColors.greyColor,
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.orangeColor),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: 'Bruno\'s Kitchen',
            navigatorObservers: [routeObserver],
            initialRoute: '/',
            navigatorKey: navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: FlutterEasyLoading(child: child!),
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
          );
        });
  }
}
