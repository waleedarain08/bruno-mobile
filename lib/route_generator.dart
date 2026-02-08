import 'package:brunos_kitchen/screens/add_address_detail_screen.dart';
import 'package:brunos_kitchen/screens/add_address_screen.dart';
import 'package:brunos_kitchen/screens/add_card_screen.dart';
import 'package:brunos_kitchen/screens/address_detail_screen.dart';
import 'package:brunos_kitchen/screens/address_screen.dart';
import 'package:brunos_kitchen/screens/blogs_news_detail_screen.dart';
import 'package:brunos_kitchen/screens/blogs_screen.dart';
import 'package:brunos_kitchen/screens/bottom_navigation_screen.dart';
import 'package:brunos_kitchen/screens/card_list_screen.dart';
import 'package:brunos_kitchen/screens/cart_screen.dart';
import 'package:brunos_kitchen/screens/checkout_screen.dart';
import 'package:brunos_kitchen/screens/choose_your_plan_screen.dart';
import 'package:brunos_kitchen/screens/delete_account_screen.dart';
import 'package:brunos_kitchen/screens/delivery_dates_screen.dart';
import 'package:brunos_kitchen/screens/edit_profile_screen.dart';
import 'package:brunos_kitchen/screens/faq_screen.dart';
import 'package:brunos_kitchen/screens/feedback_screen.dart';
import 'package:brunos_kitchen/screens/feeding_plan_screen.dart';
import 'package:brunos_kitchen/screens/forget_password_screen.dart';
import 'package:brunos_kitchen/screens/help_screen.dart';
import 'package:brunos_kitchen/screens/logIn_screen.dart';
import 'package:brunos_kitchen/screens/monthly_plan_screen.dart';
import 'package:brunos_kitchen/screens/news_screen.dart';
import 'package:brunos_kitchen/screens/one_time_plan_screen.dart';
import 'package:brunos_kitchen/screens/order_confirmation_screen.dart';
import 'package:brunos_kitchen/screens/order_detail_screen.dart';
import 'package:brunos_kitchen/screens/orders_screen.dart';
import 'package:brunos_kitchen/screens/otp_screen.dart';
import 'package:brunos_kitchen/screens/paw_points_screen.dart';
import 'package:brunos_kitchen/screens/product_detail_screen.dart';
import 'package:brunos_kitchen/screens/profile_screen.dart';
import 'package:brunos_kitchen/screens/puppies_list_screen.dart';
import 'package:brunos_kitchen/screens/puppy_confirmation_screen.dart';
import 'package:brunos_kitchen/screens/puppy_creation_additional_screen.dart';
import 'package:brunos_kitchen/screens/puppy_creation_screen.dart';
import 'package:brunos_kitchen/screens/puppy_detail_screen.dart';
import 'package:brunos_kitchen/screens/register_user_continue_screen.dart';
import 'package:brunos_kitchen/screens/register_user_screen.dart';
import 'package:brunos_kitchen/screens/reset_password_screen.dart';
import 'package:brunos_kitchen/screens/reset_password_success_screen.dart';
import 'package:brunos_kitchen/screens/splash_screen.dart';
import 'package:brunos_kitchen/screens/transitional_plan_screen.dart';
import 'package:brunos_kitchen/screens/user_verified_screen.dart';
import 'package:flutter/material.dart';

const String splashRoute = '/';
const String loginRoute = '/login';
const String registerUserRoute = '/register_user';
const String registerUserContinueRoute = '/register_user_continue';
const String otpRoute = '/otp';
const String userVerifiedRoute = '/user_verified';
const String pawPointsRoute = '/paw_points';
const String bottomNavigationRoute = '/bottom_navigation';
/*
const String shareAddressRoute = '/share_address';
*/
const String editProfileRoute = '/edit_profile';
const String ordersRoute = '/orders';
const String puppiesListRoute = '/puppiesList';
const String feedingPlanRoute = '/feedingPlan';
const String deliveryDatesRoute = '/delivery_dates';
const String puppyCreationRoute = '/puppy_creation';
const String puppyAdditionalRoute = '/puppyAdditional';
const String puppyConfirmationRoute = '/puppyConfirmation';
const String choosePlanRoute = '/choosePlan';
const String transitionPlanRoute = '/transitionPlan';
const String monthlyPlanRoute = '/monthlyPlan';
const String checkOutRoute = '/checkOut';
const String oneTimePlanRoute = '/oneTimePlan';
const String orderConfirmationRoute = '/orderConfirmation';
const String addressRoute = '/address';
const String faqRoute = '/faq';
const String forgetPasswordRoute = '/forgetPassword';
const String resetPasswordRoute = '/resetPassword';
const String resetPasswordSuccessRoute = '/resetPasswordSuccess';
const String puppyDetailRoute = '/puppyDetail';
const String addAddressRoute = '/addAddress';
const String addressDetailRoute = '/addressDetail';
const String productDetailRoute = '/productDetail';
const String addAddressDetailRoute = '/addAddressDetail';
const String cartRoute = '/cart';
const String blogsRoute = '/blogs';
const String blogsDetailRoute = '/blogsDetail';

const String helpRoute = '/help';
const String newsRoute = '/news';
const String deleteAccountRoute = '/deleteAccount';
const String orderDetailRoute = '/orderDetail';
const String addCardRoute = 'addCard';
const String chooseCardRoute = 'chooseCard';
const String feedbackRoute = 'feedback';
const String profileRoute = '/profile';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
            settings: const RouteSettings(name: splashRoute));
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(),
            settings: const RouteSettings(name: loginRoute));
      case registerUserRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterUserScreen(),
            settings: const RouteSettings(name: registerUserRoute));
      case registerUserContinueRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterUserContinueScreen(),
            settings: const RouteSettings(name: registerUserContinueRoute));
      case otpRoute:
        return MaterialPageRoute(
            builder: (_) => const OtpScreen(),
            settings: const RouteSettings(name: otpRoute));
      case userVerifiedRoute:
        return MaterialPageRoute(
            builder: (_) => const UserVerifiedScreen(),
            settings: const RouteSettings(name: userVerifiedRoute));
      case pawPointsRoute:
        return MaterialPageRoute(
            builder: (_) => const PawPointsScreen(),
            settings: const RouteSettings(name: pawPointsRoute));
      case bottomNavigationRoute:
        return MaterialPageRoute(
            builder: (_) => const BottomNavigationScreen(),
            settings: const RouteSettings(name: bottomNavigationRoute));
      /* case shareAddressRoute:
        return MaterialPageRoute(builder: (_) => const AddressIntroScreen());*/
      case editProfileRoute:
        return MaterialPageRoute(
            builder: (_) => const EditProfileScreen(),
            settings: const RouteSettings(name: editProfileRoute));
      case ordersRoute:
        return MaterialPageRoute(
            builder: (_) => const OrdersScreen(),
            settings: const RouteSettings(name: ordersRoute));
      case puppyCreationRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppyCreationScreen(),
            settings: const RouteSettings(name: puppyCreationRoute));
      case puppiesListRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppiesListScreen(),
            settings: const RouteSettings(name: puppiesListRoute));
      case puppyAdditionalRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppyCreationAdditionalScreen(),
            settings: const RouteSettings(name: puppyAdditionalRoute));
      case puppyConfirmationRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppyConfirmationScreen(),
            settings: const RouteSettings(name: puppyConfirmationRoute));
      case choosePlanRoute:
        return MaterialPageRoute(
            builder: (_) => const ChooseYourPlanScreen(),
            settings: const RouteSettings(name: choosePlanRoute));
      case transitionPlanRoute:
        return MaterialPageRoute(
            builder: (_) => const TransitionalPlanScreen(),
            settings: const RouteSettings(name: transitionPlanRoute));
      case monthlyPlanRoute:
        return MaterialPageRoute(
            builder: (_) => const MonthlyPlanScreen(),
            settings: const RouteSettings(name: monthlyPlanRoute));
      case feedingPlanRoute:
        return MaterialPageRoute(
            builder: (_) => const FeedingPlanScreen(),
            settings: const RouteSettings(name: feedingPlanRoute));
      case deliveryDatesRoute:
        return MaterialPageRoute(
            builder: (_) => const DeliveryDatesScreen(),
            settings: const RouteSettings(name: deliveryDatesRoute));
      case checkOutRoute:
        return MaterialPageRoute(
            builder: (_) => const CheckoutScreen(),
            settings: const RouteSettings(name: checkOutRoute));
      case orderConfirmationRoute:
        return MaterialPageRoute(
            builder: (_) => const OrderConfirmationScreen(),
            settings: const RouteSettings(name: orderConfirmationRoute));
      case oneTimePlanRoute:
        return MaterialPageRoute(
            builder: (_) => const OneTimePlanScreen(),
            settings: const RouteSettings(name: oneTimePlanRoute));
      case addressRoute:
        return MaterialPageRoute(
            builder: (_) => const AddressScreen(),
            settings: const RouteSettings(name: addressRoute));
      case faqRoute:
        return MaterialPageRoute(
            builder: (_) => const FaqScreen(),
            settings: const RouteSettings(name: faqRoute));
      case forgetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => const ForgetPasswordScreen(),
            settings: const RouteSettings(name: forgetPasswordRoute));
      case resetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => const ResetPasswordScreen(),
            settings: const RouteSettings(name: resetPasswordRoute));
      case resetPasswordSuccessRoute:
        return MaterialPageRoute(
            builder: (_) => const ResetPasswordSuccessScreen(),
            settings: const RouteSettings(name: resetPasswordSuccessRoute));
      case puppyDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppyDetailScreen(),
            settings: const RouteSettings(name: puppyDetailRoute));
      case addAddressRoute:
        return MaterialPageRoute(
            builder: (_) => const AddAddressScreen(),
            settings: const RouteSettings(name: addAddressRoute));
      case addressDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const AddressDetailScreen(),
            settings: const RouteSettings(name: addressDetailRoute));
      case addAddressDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const AddAddressDetailScreen(),
            settings: const RouteSettings(name: addAddressDetailRoute));
      case productDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const ProductDetailScreen(),
            settings: const RouteSettings(name: productDetailRoute));
      case cartRoute:
        return MaterialPageRoute(
            builder: (_) => const CartScreen(),
            settings: const RouteSettings(name: cartRoute));
      case blogsRoute:
        return MaterialPageRoute(
            builder: (_) => const BlogsScreen(),
            settings: const RouteSettings(name: blogsRoute));
      case blogsDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const BlogsNewsDetailScreen(),
            settings: const RouteSettings(name: blogsDetailRoute));
      case helpRoute:
        return MaterialPageRoute(
            builder: (_) => const HelpScreen(),
            settings: const RouteSettings(name: helpRoute));
      case newsRoute:
        return MaterialPageRoute(
            builder: (_) => const NewsScreen(),
            settings: const RouteSettings(name: newsRoute));
      case orderDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const OrderDetailScreen(),
            settings: const RouteSettings(name: orderDetailRoute));
      case chooseCardRoute:
        return MaterialPageRoute(
            builder: (_) => const CardListScreen(),
            settings: const RouteSettings(name: chooseCardRoute));
      case addCardRoute:
        return MaterialPageRoute(
            builder: (_) => const AddCardScreen(),
            settings: const RouteSettings(name: addCardRoute));
      case deleteAccountRoute:
        return MaterialPageRoute(
            builder: (_) => const DeleteAccountScreen(),
            settings: const RouteSettings(name: deleteAccountRoute));
      case feedbackRoute:
        return MaterialPageRoute(
            builder: (_) => const FeedbackScreen(),
            settings: const RouteSettings(name: feedbackRoute));
      case '/tasting_details':
      /*return MaterialPageRoute(
            builder: (_) => const TastingDetailsScreen(),
            settings: const RouteSettings(name: '/tasting_details'));*/
      case '/wines_details':
      /*return MaterialPageRoute(
            builder: (_) => WinesDetailScreen(
                  reviewButton: args,
                ),
            settings: const RouteSettings(name: '/wines_details'));*/
      case profileRoute:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
            settings: const RouteSettings(name: profileRoute));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Something wrong in routes'),
        ),
      );
    });
  }
}
