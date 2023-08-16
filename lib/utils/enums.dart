enum Screens {
  home("Home"),
  profile("Profile"),
  forgetPassword("ForgetPassword"),
  registerUser("RegisterUser")
  ;

  const Screens(this.text);

  final String text;
}

enum Plans {
  transitional("Transitional"),
  monthly("Monthly"),
  oneTime("OneTime");

  const Plans(this.text);

  final String text;
}


enum Puppy {
  boy("boy"),
  girl("girl"),
  active('active'),
  veryActive('veryActive'),
  lessActive('lessActive');

  const Puppy(this.text);

  final String text;
}

enum AddressLabels {
  home("Home"),
  work("Work"),
  partner('Partner'),
  other('Other');

  const AddressLabels(this.text);

  final String text;
}



enum SharedPreferencesKeys {
  authToken("auth_token");

  const SharedPreferencesKeys(this.text);

  final String text;
}

enum EndPoints {
  signIn('auth/login'),
  signUp('auth/'),
  forgotPassword('auth/forgot-password'),
  splash('user/'),
  editUserProfile('user/'),
  socialLogin('auth/social-login'),
  checkPhoneNumber('auth/phoneNumber?'),
  breeds('pet/breeds'),
  addBreeds('pet/breed'),
  puppies('pet/user'),
  registerPuppy('pet/'),
  allAddresses('user/locations'),
  addAddress('user/location'),
  deleteAddress('user/location/');


  final String url;

  const EndPoints(this.url);
}
