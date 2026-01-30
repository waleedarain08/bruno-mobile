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
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerUserRoute:
        return MaterialPageRoute(builder: (_) => const RegisterUserScreen());
      case registerUserContinueRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterUserContinueScreen());
      case otpRoute:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case userVerifiedRoute:
        return MaterialPageRoute(builder: (_) => const UserVerifiedScreen());
      case pawPointsRoute:
        return MaterialPageRoute(builder: (_) => const PawPointsScreen());
      case bottomNavigationRoute:
        return MaterialPageRoute(
            builder: (_) => const BottomNavigationScreen());
      /* case shareAddressRoute:
        return MaterialPageRoute(builder: (_) => const AddressIntroScreen());*/
      case editProfileRoute:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case ordersRoute:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case puppyCreationRoute:
        return MaterialPageRoute(builder: (_) => const PuppyCreationScreen());
      case puppiesListRoute:
        return MaterialPageRoute(builder: (_) => const PuppiesListScreen());
      case puppyAdditionalRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppyCreationAdditionalScreen());
      case puppyConfirmationRoute:
        return MaterialPageRoute(
            builder: (_) => const PuppyConfirmationScreen());
      case choosePlanRoute:
        return MaterialPageRoute(builder: (_) => const ChooseYourPlanScreen());
      case transitionPlanRoute:
        return MaterialPageRoute(
            builder: (_) => const TransitionalPlanScreen());
      case monthlyPlanRoute:
        return MaterialPageRoute(builder: (_) => const MonthlyPlanScreen());
      case feedingPlanRoute:
        return MaterialPageRoute(builder: (_) => const FeedingPlanScreen());
      case deliveryDatesRoute:
        return MaterialPageRoute(builder: (_) => const DeliveryDatesScreen());
      case checkOutRoute:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case orderConfirmationRoute:
        return MaterialPageRoute(
            builder: (_) => const OrderConfirmationScreen());
      case oneTimePlanRoute:
        return MaterialPageRoute(builder: (_) => const OneTimePlanScreen());
      case addressRoute:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => const FaqScreen());
      case forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case resetPasswordSuccessRoute:
        return MaterialPageRoute(
            builder: (_) => const ResetPasswordSuccessScreen());
      case puppyDetailRoute:
        return MaterialPageRoute(builder: (_) => const PuppyDetailScreen());
      case addAddressRoute:
        return MaterialPageRoute(builder: (_) => const AddAddressScreen());
      case addressDetailRoute:
        return MaterialPageRoute(builder: (_) => const AddressDetailScreen());
      case addAddressDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const AddAddressDetailScreen());
      case productDetailRoute:
        return MaterialPageRoute(builder: (_) => const ProductDetailScreen());
      case cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case blogsRoute:
        return MaterialPageRoute(builder: (_) => const BlogsScreen());
      case blogsDetailRoute:
        return MaterialPageRoute(builder: (_) => const BlogsNewsDetailScreen());
      case helpRoute:
        return MaterialPageRoute(builder: (_) => const HelpScreen());
      case newsRoute:
        return MaterialPageRoute(builder: (_) => const NewsScreen());
      case orderDetailRoute:
        return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
      case chooseCardRoute:
        return MaterialPageRoute(builder: (_) => const CardListScreen());
      case addCardRoute:
        return MaterialPageRoute(builder: (_) => const AddCardScreen());
      case deleteAccountRoute:
        return MaterialPageRoute(builder: (_) => const DeleteAccountScreen());
      case feedbackRoute:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
      case '/tasting_details':
      /*return MaterialPageRoute(
            builder: (_) => const TastingDetailsScreen(),
            settings: const RouteSettings(name: '/tasting_details'));*/
      case '/wines_details':
      /*return MaterialPageRoute(
            builder: (_) => WinesDetailScreen(
                  reviewButton: args,
                ));*/
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
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
