import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

import '../main.dart';
import '../models/address_model.dart';
import '../models/base_response_model.dart';
import '../models/card_model.dart';
import '../models/puppy_model.dart';
import '../models/requests/edit_user_profile_request.dart';
import '../models/requests/forgot_password_request.dart';
import '../models/requests/otp_send_request.dart';
import '../models/requests/sign_in_request.dart';
import '../models/requests/social_sign_in_request.dart';
import '../models/requests/user_register_request.dart';
import '../models/responses/auth_response.dart';
import '../models/responses/banners_response.dart';
import '../models/responses/otp_response.dart';
import '../screens/bottom_navigation_screen.dart';
import '../screens/intro_slides_screen.dart';
import '../screens/logIn_screen.dart';
import '../services/auth_api_services.dart';
import '../utils/conversions.dart';
import '../utils/enums.dart';
import '../utils/send_grid_pref.dart';
import '../utils/shared_pref .dart';
import 'cart_view_model.dart';

class AuthViewModel with ChangeNotifier {
  String _otpRouteFrom = Screens.registerUser.text;
  String _registerRouteFrom = Screens.login.text;
  bool _securePassword = true;
  bool _showGreeting = true;
  Timer? _countdownTimer;
  Duration _myDuration = const Duration(minutes: 2);
  final AuthApiServices _authApiServices = AuthApiServices();
  AuthResponse _authResponse = AuthResponse();
  OtpResponse _otpResponse = OtpResponse();
  final List<BannerData> _bannersList = [];
  final SharedPref _sharedPref = SharedPref();

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  String _countryCode = '+971';
  String? _fcmToken;
  String _operatingSystem = '';
  String _otpType = '';

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // final TextEditingController _editPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _nameFieldError = '';
  String _emailFieldError = '';
  String _phoneFieldError = '';
  String _passwordFieldError = '';
  String _confirmPasswordFieldError = '';

  String _otpMinutes = '02';
  String _otpSeconds = '00';

  String get getOtpType => _otpType;

  void setOtpType(String value) {
    _otpType = value;
  }

  String get getOtpMinutes => _otpMinutes;

  void setOtpMinutesSeconds() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    _otpMinutes = strDigits(_myDuration.inMinutes.remainder(02));
    _otpSeconds = strDigits(_myDuration.inSeconds.remainder(60));
    notifyListeners();
  }

  String get getOtpSeconds => _otpSeconds;

  // timer settings

  Timer? get getCountdownTimer => _countdownTimer;

  // Duration get getMyDuration => _myDuration;

  void startTimer() {
    _countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;

    final seconds = _myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      _countdownTimer!.cancel();
    } else {
      _myDuration = Duration(seconds: seconds);
      setOtpMinutesSeconds();
    }
    notifyListeners();
  }

  void stopTimer() {
    if (_countdownTimer != null && _countdownTimer!.isActive) {
      _otpMinutes = '02';
      _otpSeconds = '00';
      _countdownTimer!.cancel();
      notifyListeners();
    }
  }

  void resetTimer() {
    stopTimer();
    _myDuration = const Duration(minutes: 2);
    setOtpMinutesSeconds();
    notifyListeners();
  }

  void restartTimer() {
    stopTimer();
    _myDuration = const Duration(minutes: 2);
    setOtpMinutesSeconds();
    startTimer();
    notifyListeners();
  }

  bool get getSecurePassword => _securePassword;

  bool get getShowGreeting => _showGreeting;

  List<BannerData> get getBannerList => _bannersList;

  void setBannerResponse(BannersResponse value) {
    _bannersList.clear();
    if (value.data != null) {
      final List<BannerData> featuredList =
          value.data!.where((element) => element.isFeatured!).toList();
      _bannersList.addAll(featuredList);
    }
    notifyListeners();
  }

  void setShowGreeting() {
    _showGreeting = false;
    notifyListeners();
  }

  void setSecurePassword() {
    _securePassword = !_securePassword;
    notifyListeners();
  }

  String get getCountryCode => _countryCode;

  void setCountryCode(String value) {
    _countryCode = value;
    notifyListeners();
  }

  Future<void> setAddress(AddressModel value) async {
    _authResponse.data!.location = value;
    setDeliveryCity();
    // notifyListeners();
  }

  void setDeliveryCity() async {
    final result = await convertCoordinatesToPlaces(
      latitude: double.parse(_authResponse.data!.location!.coordinates![0]),
      longitude: double.parse(_authResponse.data!.location!.coordinates![1]),
    );
    if (result == null) {
      return;
    }
    final locationCity = result.mapToPretty();
    navigatorKey.currentContext!.read<CartViewModel>().setDeliveryFee(
        locationCity.city == 'Abu Dhabi'
            ? _authResponse.data!.discounts![1].aggregate!.toInt()
            : _authResponse.data!.discounts![0].aggregate!.toInt());
    notifyListeners();
  }

  void setCard(CardModel value) {
    _authResponse.data!.card = value;
    notifyListeners();
  }

  void setPuppy(PuppyModel value) {
    _authResponse.data!.pet = value;
    notifyListeners();
  }

  AuthResponse get getAuthResponse => _authResponse;

  void setAuthResponse(AuthResponse value) {
    _authResponse = value;
    updateProfile();
    // notifyListeners();
  }

  void updateProfile() {
    _emailController.text = _authResponse.data!.email!;
    _phoneController.text = _authResponse.data!.phoneNumber!;
    _nameController.text = _authResponse.data!.fullName!;
    if (_authResponse.data!.location != null) {
      setDeliveryCity();
    } else {
      notifyListeners();
    }
  }

  String get getNameFieldError => _nameFieldError;

  void setNameFieldError(String value) {
    _nameFieldError = value;
    notifyListeners();
  }

  String get getEmailFieldError => _emailFieldError;

  void setEmailFieldError(String value) {
    _emailFieldError = value;
    notifyListeners();
  }

  String get getPhoneFieldError => _phoneFieldError;

  void setPhoneFieldError(String value) {
    _phoneFieldError = value;
    notifyListeners();
  }

  String get getPasswordFieldError => _passwordFieldError;

  void setPasswordFieldError(String value) {
    _passwordFieldError = value;
    notifyListeners();
  }

  String get getConfirmPasswordFieldError => _confirmPasswordFieldError;

  void setConfirmPasswordFieldError(String value) {
    _confirmPasswordFieldError = value;
    notifyListeners();
  }

  String get getRegisterRouteFrom => _registerRouteFrom;

  void setRegisterRouteFrom(String value) {
    _registerRouteFrom = value;
    notifyListeners();
  }

  String get getOtpRouteFrom => _otpRouteFrom;

  void setOtpRouteFrom(String value) {
    _otpRouteFrom = value;
    notifyListeners();
  }

  TextEditingController get getOtpController => _otpController;

  TextEditingController get getNameController => _nameController;

  TextEditingController get getEmailController => _emailController;

  TextEditingController get getPhoneController => _phoneController;

  //TextEditingController get getEditPhoneController => _editPhoneController;

  TextEditingController get getPasswordController => _passwordController;

  TextEditingController get getConfirmPasswordController =>
      _confirmPasswordController;

  bool nameValidation() {
    if (_nameController.text.isEmpty) {
      setNameFieldError('Please Enter Name');
      return false;
    } else {
      setNameFieldError('');
      return true;
    }
  }

  bool emailValidation() {
    if (_emailController.text.isEmpty) {
      setEmailFieldError('Please Enter Email');
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      setEmailFieldError('Please Enter Valid Email');
      return false;
    } else {
      setEmailFieldError('');
      return true;
    }
  }

  bool phoneValidation() {
    if (_phoneController.text.isEmpty) {
      setPhoneFieldError('Please Enter Phone Number');
      return false;
    } else {
      setPhoneFieldError('');
      return true;
    }
  }

  bool passwordValidation() {
    if (_passwordController.text.isEmpty) {
      setPasswordFieldError('Please Enter Password');
      return false;
    } else if (_passwordController.text.length < 8) {
      setPasswordFieldError('Password length must be of at least 8 characters');
      return false;
    } else {
      setPasswordFieldError('');
      return true;
    }
  }

  bool confirmPasswordValidation() {
    if (_confirmPasswordController.text.isEmpty) {
      setConfirmPasswordFieldError('Password didn\'t matched');
      return false;
    } else if (_confirmPasswordController.text != _passwordController.text) {
      setConfirmPasswordFieldError('Password didn\'t matched');
      return false;
    } else {
      setConfirmPasswordFieldError('');
      return true;
    }
  }

  bool signInValidation() {
    if (emailValidation() && passwordValidation()) {
      return true;
    } else {
      return false;
    }
  }

  bool userRegistrationValidation() {
    if (nameValidation() &&
        emailValidation() &&
        phoneValidation() &&
        passwordValidation() &&
        confirmPasswordValidation()) {
      return true;
    } else {
      return false;
    }
  }

  bool forgotPasswordValidation() {
    if (passwordValidation() && confirmPasswordValidation()) {
      return true;
    } else {
      return false;
    }
  }

  Future<Widget> checkSplash() async {
    //PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //setVersion(packageInfo.version);
    // setBuild(packageInfo.buildNumber);

    if (Platform.isAndroid) {
      _operatingSystem = 'Android';
    } else {
      _operatingSystem = 'iOS';
    }
    final authToken =
        await _sharedPref.read(SharedPreferencesKeys.authToken.text);
    await Future.delayed(const Duration(seconds: 4), () {});
    if (authToken == null) {
      if (kIsWeb) {
        final success = await callGuestUserRegisterApi();
        if (success) {
          return const BottomNavigationScreen();
        }
      }
      return const IntroSlidesScreen();
    } else {
      late Widget routeTo;
      await callSplash(showLoader: false).then((value) async {
        if (value) {
          routeTo = const BottomNavigationScreen();
        } else {
          routeTo = const LoginScreen();
        }
      });
      return routeTo;
    }
  }

  Future<bool> callSplash({required bool showLoader}) async {
    if (showLoader) {
      EasyLoading.show(status: 'Please Wait...');
    }
    try {
      final AuthResponse response = await _authApiServices.splashApi();
      if (response.isSuccess!) {
        setAuthResponse(response);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError(response.message!);
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callSignInApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final SignInRequest signInRequest = SignInRequest(
          password: _passwordController.text,
          email: _emailController.text,
          deviceToken: _fcmToken ?? 'token',
          deviceType: _operatingSystem);

      final AuthResponse response =
          await _authApiServices.signInApi(signInRequest: signInRequest);
      if (response.isSuccess!) {
        setAuthResponse(response);
        //  setImageSlider();
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  /* Future<bool> signInWithGoogle() async {
    EasyLoading.show(status: 'Please Wait...');
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userDetails =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userDetails.user != null) {
        // await getUserToken();
        //  final bool loginStatus =
        final SocialSignInRequest socialSignInRequest = SocialSignInRequest(
            clientId: userDetails.user!.uid,
            email: userDetails.user!.email!,
            fullName: userDetails.user!.displayName!,
            phoneNumber: userDetails.user!.phoneNumber ?? '',
            deviceType: _operatingSystem,
            deviceToken: _fcmToken ?? 'token',
            media: userDetails.user!.photoURL!,
            platform: 'Google');

        return await callSocialMediaLoginApi(userDetails: socialSignInRequest);
      } else {
        EasyLoading.showError('Something Went Wrong');
        return false;
      }
    } else {
      EasyLoading.showError('Something Went Wrong');
      return false;
    }
  }*/

/*
  Future<bool> signInWithFacebook() async {
    EasyLoading.show(status: 'Please Wait...');

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      final userDetails = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (userDetails.user != null) {
        //await getUserToken();

        final SocialSignInRequest socialSignInRequest = SocialSignInRequest(
            clientId: userDetails.user!.uid,
            email: userDetails.user!.email!,
            fullName: userDetails.user!.displayName!,
            phoneNumber: userDetails.user!.phoneNumber ?? '',
            deviceType: _operatingSystem,
            deviceToken: _fcmToken ?? 'token',
            media: userDetails.user!.photoURL!,
            platform: 'Facebook');
        return await callSocialMediaLoginApi(userDetails: socialSignInRequest);
      } else {
        EasyLoading.showError('Something Went Wrong');
        return false;
      }
    } else {
      EasyLoading.showError('Something Went Wrong');
      return false;
    }
  }
*/

/*
  Future<bool> signInWithApple() async {
    EasyLoading.show(status: 'Please Wait...');

    String generateNonce([int length = 32]) {
      final charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final appleAuthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
    );
    final userDetails =
        await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);
    if (userDetails.user != null) {
      //await getUserToken();

      final SocialSignInRequest socialSignInRequest = SocialSignInRequest(
          clientId: userDetails.user!.uid,
          email: userDetails.user!.email!,
          fullName: userDetails.user!.displayName ?? '',
          phoneNumber: userDetails.user!.phoneNumber ?? '',
          deviceType: _operatingSystem,
          deviceToken: _fcmToken ?? 'token',
          media: userDetails.user!.photoURL ?? '',
          platform: 'Apple');
      return await callSocialMediaLoginApi(userDetails: socialSignInRequest);
    } else {
      EasyLoading.showError('Something Went Wrong');
      return false;
    }
  }
*/

  Future<bool> callSocialMediaLoginApi(
      {required SocialSignInRequest userDetails}) async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final AuthResponse response = await _authApiServices.socialMediaLoginApi(
          socialSignInRequest: userDetails);
      if (response.isSuccess!) {
        setAuthResponse(response);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callForgotPasswordApi() async {
    //_otpType = OtpTypes.forgotPassword.text;
    //final bool otpVerification = await verifyingOtp();
    /* if (otpVerification) {*/
    try {
      EasyLoading.show(status: 'Please Wait ...');
      final ForgotPasswordRequest forgotPasswordRequest = ForgotPasswordRequest(
          password: _passwordController.text,
          phoneNumber: _emailController.text);

      final BaseResponseModel response = await _authApiServices
          .forgotPasswordApi(forgotPasswordRequest: forgotPasswordRequest);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
    /*} else {
      return false;
    }*/
  }

  Future<bool> callGuestUserRegisterApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final UserRegisterRequest userRegisterRequest = UserRegisterRequest(
          password: '',
          email: '',
          deviceToken: _fcmToken ?? 'token',
          deviceType: _operatingSystem,
          fullName: 'Guest',
          phoneNumber: '');

      final AuthResponse response = await _authApiServices.guestUserRegisterApi(
          userRegisterRequest: userRegisterRequest);
      if (response.isSuccess!) {
        setAuthResponse(response);
        //  setImageSlider();
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callUserRegisterApi() async {
    _otpType = OtpTypes.register.text;
    final bool otpVerification = await verifyingOtp();
    if (otpVerification) {
      try {
        EasyLoading.show(status: 'Please Wait ...');
        SendGridPref sendGrid = SendGridPref();
        final UserRegisterRequest userRegisterRequest = UserRegisterRequest(
            password: _passwordController.text,
            email: _emailController.text,
            deviceToken: _fcmToken ?? 'token',
            deviceType: _operatingSystem,
            fullName: _nameController.text,
            phoneNumber: _countryCode + _phoneController.text);

        final AuthResponse response = await _authApiServices.userRegisterApi(
            userRegisterRequest: userRegisterRequest);
        if (response.isSuccess!) {
          setAuthResponse(response);
          //  setImageSlider();
          sendGrid.sendEmail(
              emailSubject: 'Registration',
              emailDescription:
                  '${_nameController.text} Register Successfully');
          EasyLoading.dismiss();
          return true;
        } else {
          EasyLoading.showError('${response.message}');
          return false;
        }
      } catch (e) {
        EasyLoading.showError(e.toString());
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkPhoneNumber({required bool checkType}) async {
    EasyLoading.show(status: 'Please Wait');
    try {
      final BaseResponseModel response =
          await _authApiServices.checkPhoneNumberApi(
              phoneNumber: _countryCode + _phoneController.text);
      if (response.isSuccess!) {
        if (!checkType) {
          checkEmail();
          EasyLoading.showError('${response.message}');
        } else {
          EasyLoading.dismiss();
        }
        return true;
      } else {
        if (checkType) {
          EasyLoading.showError('${response.message}');
        } else {
          final bool emailVerification = await checkEmail();
          return emailVerification;
        }
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> checkEmail() async {
    //EasyLoading.show(status: 'Please Wait Verify Email');
    try {
      final BaseResponseModel response = await _authApiServices.checkEmailApi(
          emailAddress: _emailController.text);
      if (response.isSuccess!) {
        EasyLoading.showError(response.message!);
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> sendingOtp() async {
    EasyLoading.show(status: 'Sending OTP');
    try {
      final OtpResponse response = await _authApiServices.sendOtp(
          otpSendRequest:
              OtpSendRequest(email: _emailController.text, type: _otpType));
      if (response.isSuccess!) {
        _otpResponse = response;
        restartTimer();
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError(response.message!);
        resetTimer();
        return false;
      }
    } catch (exception) {
      resetTimer();
      EasyLoading.showError(exception.toString());
      return false;
    }
  }

  Future<bool> verifyingOtp() async {
    EasyLoading.show(status: 'Sending OTP');
    if (_otpResponse.data != null &&
        _otpResponse.data!.otp == _otpController.text) {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.showError('Wrong OTP');
      return false;
    }
    /*   try {
      resetTimer();
      //bool returnValue = false;

      final BaseResponseModel response = await _authApiServices.verifyOtp(
        otpVerifyRequest: OtpVerifyRequest(email: _emailController.text, otp: _otpController.text, type: _otpType));
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError(response.message!);
        EasyLoading.dismiss();
        return false;
      }
    } catch (exception) {
      EasyLoading.showError(exception.toString());
      EasyLoading.dismiss();
      return false;
    }*/
  }

/*
  Future<bool> verifyOTPFirebase() async {
    try {
      EasyLoading.show(status: 'Verify OTP');

      final credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: _verificationId, smsCode: _otpController.text));
      EasyLoading.dismiss();
      return credentials.user != null ? true : false;
    } catch (exception) {
      EasyLoading.showToast(exception.toString());
      return false;
    }
  }
*/

  Future<bool> editUserProfileApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final EditUserProfileRequest editUserProfileRequest =
          EditUserProfileRequest(
              fullName: _nameController.text,
              phoneNumber: _phoneController.text);

      final AuthResponse response = await _authApiServices.editUserProfileApi(
          editUserProfileRequest: editUserProfileRequest);
      if (response.isSuccess!) {
        setAuthResponse(response);
        //  setImageSlider();
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<void> callBanners() async {
    try {
      final BannersResponse bannersResponse =
          await _authApiServices.bannersApi();
      setBannerResponse(bannersResponse);
    } catch (exception) {
      EasyLoading.showToast(exception.toString());
    }
  }

  void callLogOut() {
    _sharedPref.remove(SharedPreferencesKeys.authToken.text);
    navigatorKey.currentContext!.read<CartViewModel>().clearCart();
  }

  void clearFieldsData() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _securePassword = true;
    _confirmPasswordController.clear();
    setNameFieldError('');
    setEmailFieldError('');
    setPhoneFieldError('');
    setPasswordFieldError('');
    setConfirmPasswordFieldError('');
  }
}
