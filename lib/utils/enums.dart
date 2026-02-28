enum Screens {
  home("Home"),
  profile("Profile"),
  forgetPassword("ForgetPassword"),
  registerUser("RegisterUser"),
  login("Login"),
  cart("cart"),
  shop("shop");

  const Screens(this.text);

  final String text;
}

enum Contact {
  email("hello@brunos.kitchen"),
  phone("+971 58 575 9205"),
  webUrl('https://brunos.kitchen/'),
  location('https://g.co/kgs/cBA99Wd'),
  termAndConditionUrl('https://admin.brunos.kitchen/terms&conditions'),
  privacyPolicyUrl('https://admin.brunos.kitchen/privacy-policy'),
  agreementUrl('https://admin.brunos.kitchen/user-agreement');

  const Contact(this.text);

  final String text;
}

enum Plans {
  transitional("Transitional"),
  monthly("Monthly"),
  //oneTime("OneTime"),
  product("Product");

  const Plans(this.text);

  final String text;
}

enum ProductCategories {
  standardRecipes("Standard Recipes"),
  clothing("Clothing"),
  toys("Toys");

  const ProductCategories(this.text);

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

enum PuppyWeight {
  idealWeight(10),
  overweight(20),
  underweight(5);

  final int value;

  const PuppyWeight(this.value);
}

enum Discounts {
  discountPercentageOnMonthlyPlan('discountPercentageOnMonthlyPlan'),
  discountOnPointsRedeem('discountOnPointsRedeem'),
  pointsToAEDRatio('pointsToAEDRatio');

  final String text;

  const Discounts(this.text);
}

enum AddressLabels {
  home("Home"),
  work("Work"),
  partner('Partner'),
  other('Other');

  const AddressLabels(this.text);

  final String text;
}

enum FeaturedRecipeType {
  adult("Adult"),
  puppy('Puppy');

  const FeaturedRecipeType(this.text);

  final String text;
}

enum OtpTypes {
  register("SignUp"),
  forgotPassword('forgotPassword');

  const OtpTypes(this.text);

  final String text;
}

enum SharedPreferencesKeys {
  authToken("auth_token"),
  stripeId("stripe_id");

  const SharedPreferencesKeys(this.text);

  final String text;
}

enum EndPoints {
  signIn('auth/login'),
  signUp('auth/'),
  guest('auth/guest'),
  allNews('news-FAQ/type/newsAndBlog'),
  allBlogs('news-FAQ/type/blogs'),
  banners('news-FAQ/type/banners'),
  allFaqs('news-FAQ/type/FAQ'),
  addFeedback('news-FAQ/'),
  forgotPassword('auth/forgot-password'),
  splash('user/'),
  sendOtp('auth/send-otp'),
  verifyOtp('auth/varify-otp'),
  editUserProfile('user/'),
  socialLogin('auth/social-login'),
  checkPhoneNumber('auth/phoneNumber?'),
  checkEmail('auth/email?'),
  breeds('pet/breeds'),
  addBreeds('pet/breed'),
  puppies('pet/user'),
  registerPuppy('pet/'),
  allAddresses('user/locations'),
  allRecipes('recipe/'),
  addAddress('user/location'),
  checkLocation('auth/checkLocation'),
  defaultAddress('user/default/location/'),
  defaultCard('card/default/'),
  defaultPuppy('pet/default/'),
  createOrder('order/'),
  allOrder('order/'),
  addCard('card/'),
  deleteCard('card/'),
  allCards('card'),
  allStripeCards('card/get_stripe_cards/'),
  setupIntent('card/setup_intent/'),
  promoIsValid('promo-code/name/'),
  deleteAddress('user/location/'),
  placesSearch('user/search-locations');

  final String url;

  const EndPoints(this.url);
}
