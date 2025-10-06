import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Widam'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @deals.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get deals;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @earliestDelivery.
  ///
  /// In en, this message translates to:
  /// **'Earliest\nDelivery'**
  String get earliestDelivery;

  /// No description provided for @searchForAnyProduct.
  ///
  /// In en, this message translates to:
  /// **'Search for any product'**
  String get searchForAnyProduct;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @orderAgain.
  ///
  /// In en, this message translates to:
  /// **'Order Again'**
  String get orderAgain;

  /// No description provided for @expressDelivery.
  ///
  /// In en, this message translates to:
  /// **'Express Delivery'**
  String get expressDelivery;

  /// No description provided for @chooseYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose your location'**
  String get chooseYourLocation;

  /// No description provided for @enterLocationName.
  ///
  /// In en, this message translates to:
  /// **'Enter location name'**
  String get enterLocationName;

  /// No description provided for @locateMe.
  ///
  /// In en, this message translates to:
  /// **'Locate Me'**
  String get locateMe;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM LOCATION'**
  String get confirmLocation;

  /// No description provided for @locationEnableMessage.
  ///
  /// In en, this message translates to:
  /// **'Enable location service so we know where to drop your order'**
  String get locationEnableMessage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @viewAllCategories.
  ///
  /// In en, this message translates to:
  /// **'View All Categories'**
  String get viewAllCategories;

  /// No description provided for @express.
  ///
  /// In en, this message translates to:
  /// **'Express'**
  String get express;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your \nmobile number!'**
  String get enterYourMobileNumber;

  /// No description provided for @loginDes.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number to register or to\nsign-in to your existing account, we will send verification code!'**
  String get loginDes;

  /// No description provided for @enterYourMobileNo.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile no.'**
  String get enterYourMobileNo;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @mustBeEightDigits.
  ///
  /// In en, this message translates to:
  /// **'Must be 8 digits'**
  String get mustBeEightDigits;

  /// No description provided for @qatariPhoneNumberValidator.
  ///
  /// In en, this message translates to:
  /// **'Qatari phone number must start with 3, 5, 6, or 7'**
  String get qatariPhoneNumberValidator;

  /// No description provided for @priceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Price High to Low'**
  String get priceHighToLow;

  /// No description provided for @priceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Price Low to High'**
  String get priceLowToHigh;

  /// No description provided for @nameAtoZ.
  ///
  /// In en, this message translates to:
  /// **'Name A to Z'**
  String get nameAtoZ;

  /// No description provided for @nameZtoA.
  ///
  /// In en, this message translates to:
  /// **'Name Z to A'**
  String get nameZtoA;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get bestSeller;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @otpHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Hello Again!\nLet\'s verify your number.'**
  String get otpHeaderTitle;

  /// No description provided for @otpHeaderDes.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a code. Please enter the received code to proceed.'**
  String get otpHeaderDes;

  /// No description provided for @dontReceiveTheCode.
  ///
  /// In en, this message translates to:
  /// **'Don\'t receive the code?'**
  String get dontReceiveTheCode;

  /// No description provided for @resendMyCode.
  ///
  /// In en, this message translates to:
  /// **'Resend my code'**
  String get resendMyCode;

  /// No description provided for @youHave.
  ///
  /// In en, this message translates to:
  /// **'You have'**
  String get youHave;

  /// No description provided for @attemptsLeft.
  ///
  /// In en, this message translates to:
  /// **'attempts left'**
  String get attemptsLeft;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @otpMinLength.
  ///
  /// In en, this message translates to:
  /// **'Should be 6 digits'**
  String get otpMinLength;

  /// No description provided for @newAccount.
  ///
  /// In en, this message translates to:
  /// **'New account!'**
  String get newAccount;

  /// No description provided for @newAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'No account linked to your phone number. We\'ll create a new one using this number'**
  String get newAccountDesc;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @mr.
  ///
  /// In en, this message translates to:
  /// **'Mr.'**
  String get mr;

  /// No description provided for @mrs.
  ///
  /// In en, this message translates to:
  /// **'Mrs.'**
  String get mrs;

  /// No description provided for @missOrMs.
  ///
  /// In en, this message translates to:
  /// **'Miss/Ms.'**
  String get missOrMs;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get firstNameHint;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get lastNameHint;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email (optional)'**
  String get emailHint;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @dateOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'Pick your date of birth'**
  String get dateOfBirthHint;

  /// No description provided for @termAndConditionsPrefix.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the'**
  String get termAndConditionsPrefix;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @selectYourProducts.
  ///
  /// In en, this message translates to:
  /// **'Select Your\nProducts'**
  String get selectYourProducts;

  /// No description provided for @setYourSchedule.
  ///
  /// In en, this message translates to:
  /// **'Set Your\nSchedule'**
  String get setYourSchedule;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @reviewAndConfirm.
  ///
  /// In en, this message translates to:
  /// **'Review \n& confirm'**
  String get reviewAndConfirm;

  /// No description provided for @chooseYourSchedule.
  ///
  /// In en, this message translates to:
  /// **'Choose your schedule'**
  String get chooseYourSchedule;

  /// No description provided for @chooseYourScheduleDescription.
  ///
  /// In en, this message translates to:
  /// **'We deliver your product every day/ week/ month '**
  String get chooseYourScheduleDescription;

  /// No description provided for @allProducts.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get allProducts;

  /// No description provided for @selectOptions.
  ///
  /// In en, this message translates to:
  /// **'Select Options'**
  String get selectOptions;

  /// No description provided for @setUpYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Set up your plan'**
  String get setUpYourPlan;

  /// No description provided for @unsubscribe.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribe;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @biWeekly.
  ///
  /// In en, this message translates to:
  /// **'Bi Weekly'**
  String get biWeekly;

  /// No description provided for @biMonthly.
  ///
  /// In en, this message translates to:
  /// **'Bi Monthly'**
  String get biMonthly;

  /// No description provided for @subscriptionStartsOn.
  ///
  /// In en, this message translates to:
  /// **'Subscription starts on'**
  String get subscriptionStartsOn;

  /// No description provided for @subscriptionEndsOn.
  ///
  /// In en, this message translates to:
  /// **'Subscription ends on'**
  String get subscriptionEndsOn;

  /// No description provided for @pickYouTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Pick your time slot'**
  String get pickYouTimeSlot;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @editTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit The Title'**
  String get editTitle;

  /// No description provided for @enterAnewTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a new title'**
  String get enterAnewTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @yourSubscription.
  ///
  /// In en, this message translates to:
  /// **'Your subscription'**
  String get yourSubscription;

  /// No description provided for @isReadyForSubmission.
  ///
  /// In en, this message translates to:
  /// **'is ready for submission!'**
  String get isReadyForSubmission;

  /// No description provided for @subscriptionDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a notification prior to your\nnext scheduled delivery.'**
  String get subscriptionDescription;

  /// No description provided for @subscriptionDetails.
  ///
  /// In en, this message translates to:
  /// **'Subscription Details'**
  String get subscriptionDetails;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @specifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specifications;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @mustBeElevenDigits.
  ///
  /// In en, this message translates to:
  /// **'Must be 11 digits'**
  String get mustBeElevenDigits;

  /// No description provided for @pickImage.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImage;

  /// No description provided for @pleaseSelectImageSource.
  ///
  /// In en, this message translates to:
  /// **'Please select image source'**
  String get pleaseSelectImageSource;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @qidAttached.
  ///
  /// In en, this message translates to:
  /// **'QID attached'**
  String get qidAttached;

  /// No description provided for @qidValidMessage.
  ///
  /// In en, this message translates to:
  /// **'This ID has been validated successfully!'**
  String get qidValidMessage;

  /// No description provided for @qidInvalidMessage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this ID is incorrect :('**
  String get qidInvalidMessage;

  /// No description provided for @validateButtonMessage.
  ///
  /// In en, this message translates to:
  /// **'Please validate your ID'**
  String get validateButtonMessage;

  /// No description provided for @profileGreetings.
  ///
  /// In en, this message translates to:
  /// **'Hello! Nice to meet you'**
  String get profileGreetings;

  /// No description provided for @profileGreetingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the destination for all your fresh needs, tailored for families in Qatar.'**
  String get profileGreetingsDescription;

  /// No description provided for @loginOrRegister.
  ///
  /// In en, this message translates to:
  /// **'Login Or Register'**
  String get loginOrRegister;

  /// No description provided for @editYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Your Profile'**
  String get editYourProfile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageValue.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageValue;

  /// No description provided for @requestError.
  ///
  /// In en, this message translates to:
  /// **'Request Error'**
  String get requestError;

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad Request'**
  String get badRequest;

  /// No description provided for @unprocessableEntity.
  ///
  /// In en, this message translates to:
  /// **'Unprocessable Entity'**
  String get unprocessableEntity;

  /// No description provided for @internalServerError.
  ///
  /// In en, this message translates to:
  /// **'Internal Server Error'**
  String get internalServerError;

  /// No description provided for @conflictConnection.
  ///
  /// In en, this message translates to:
  /// **'Conflict Connection'**
  String get conflictConnection;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get unauthorized;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnection;

  /// No description provided for @deadlineExceeded.
  ///
  /// In en, this message translates to:
  /// **'Deadline Exceeded'**
  String get deadlineExceeded;

  /// No description provided for @accessForbidden.
  ///
  /// In en, this message translates to:
  /// **'Access Forbidden'**
  String get accessForbidden;

  /// No description provided for @badCertificate.
  ///
  /// In en, this message translates to:
  /// **'Bad Certificate'**
  String get badCertificate;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get connectionError;

  /// No description provided for @yourCartDetails.
  ///
  /// In en, this message translates to:
  /// **'Your Cart Details'**
  String get yourCartDetails;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @activeSubscription.
  ///
  /// In en, this message translates to:
  /// **'Active\nSubscription'**
  String get activeSubscription;

  /// No description provided for @pastOrders.
  ///
  /// In en, this message translates to:
  /// **'Past\nOrders'**
  String get pastOrders;

  /// No description provided for @yourCoupons.
  ///
  /// In en, this message translates to:
  /// **'Your\nCoupons'**
  String get yourCoupons;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @qatar.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get qatar;

  /// No description provided for @yourDetails.
  ///
  /// In en, this message translates to:
  /// **'Your Details'**
  String get yourDetails;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @reachOutToUs.
  ///
  /// In en, this message translates to:
  /// **'Reach out to us'**
  String get reachOutToUs;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @ourService.
  ///
  /// In en, this message translates to:
  /// **'Our service'**
  String get ourService;

  /// No description provided for @corporateVideo.
  ///
  /// In en, this message translates to:
  /// **'Corporate Video'**
  String get corporateVideo;

  /// No description provided for @complaints.
  ///
  /// In en, this message translates to:
  /// **'Complaints'**
  String get complaints;

  /// No description provided for @allRightsReserved.
  ///
  /// In en, this message translates to:
  /// **'2026 - Widam - all right reserved'**
  String get allRightsReserved;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @myAddressees.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get myAddressees;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @editProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'You can edit your profile here. The mobile number associated with your account cannot be modified:'**
  String get editProfileDesc;

  /// No description provided for @accountDeletion.
  ///
  /// In en, this message translates to:
  /// **'Account Deletion'**
  String get accountDeletion;

  /// No description provided for @accountDeletionDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'re sorry to see you go, but we hope to see you again in the future!'**
  String get accountDeletionDesc;

  /// No description provided for @deleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete your account'**
  String get deleteYourAccount;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @deliveryCharges.
  ///
  /// In en, this message translates to:
  /// **'Delivery Charges'**
  String get deliveryCharges;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// No description provided for @changeTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Change\nTime Slot'**
  String get changeTimeSlot;

  /// No description provided for @openingHoures.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get openingHoures;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pick-Up Location'**
  String get pickupLocation;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order Total'**
  String get orderTotal;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed To Checkout'**
  String get proceedToCheckout;

  /// No description provided for @selectYourDeliverySlot.
  ///
  /// In en, this message translates to:
  /// **'Select your delivery slot'**
  String get selectYourDeliverySlot;

  /// No description provided for @selectYourPickupSlot.
  ///
  /// In en, this message translates to:
  /// **'Select your pickup slot'**
  String get selectYourPickupSlot;

  /// No description provided for @fullyBooked.
  ///
  /// In en, this message translates to:
  /// **'Fully Booked'**
  String get fullyBooked;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @youHaveItemsAddedToYourCart.
  ///
  /// In en, this message translates to:
  /// **'You have items added to your cart'**
  String get youHaveItemsAddedToYourCart;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get viewCart;

  /// No description provided for @yourAddresses.
  ///
  /// In en, this message translates to:
  /// **'Your Addresses'**
  String get yourAddresses;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// No description provided for @existingAddresses.
  ///
  /// In en, this message translates to:
  /// **'Existing Addresses'**
  String get existingAddresses;

  /// No description provided for @locationInformation.
  ///
  /// In en, this message translates to:
  /// **'Location Information'**
  String get locationInformation;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address Details (Inwani)'**
  String get addressDetails;

  /// No description provided for @cityName.
  ///
  /// In en, this message translates to:
  /// **'City Name'**
  String get cityName;

  /// No description provided for @cityNameHint.
  ///
  /// In en, this message translates to:
  /// **'Select your city'**
  String get cityNameHint;

  /// No description provided for @zoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Zone Number'**
  String get zoneNumber;

  /// No description provided for @zoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Select your zone'**
  String get zoneNumberHint;

  /// No description provided for @areaName.
  ///
  /// In en, this message translates to:
  /// **'Area Name'**
  String get areaName;

  /// No description provided for @areaNameHint.
  ///
  /// In en, this message translates to:
  /// **'Select your area name'**
  String get areaNameHint;

  /// No description provided for @streetNo.
  ///
  /// In en, this message translates to:
  /// **'Street No.'**
  String get streetNo;

  /// No description provided for @streetNoHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your street number'**
  String get streetNoHint;

  /// No description provided for @buildingNo.
  ///
  /// In en, this message translates to:
  /// **'Building No.'**
  String get buildingNo;

  /// No description provided for @buildingNoHint.
  ///
  /// In en, this message translates to:
  /// **'Building or compound number'**
  String get buildingNoHint;

  /// No description provided for @makeThisDefault.
  ///
  /// In en, this message translates to:
  /// **'Make This Default'**
  String get makeThisDefault;

  /// No description provided for @reciverInformation.
  ///
  /// In en, this message translates to:
  /// **'Reciver Information'**
  String get reciverInformation;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @mobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile No.'**
  String get mobileNo;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address Label'**
  String get addressLabel;

  /// No description provided for @villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get villa;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @updateAddress.
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get updateAddress;

  /// No description provided for @selectYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Select Your Address'**
  String get selectYourAddress;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @shipTo.
  ///
  /// In en, this message translates to:
  /// **'Ship To'**
  String get shipTo;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @applyCoupon.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupon'**
  String get applyCoupon;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Cart Total'**
  String get cartTotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @reviewYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Review Your Order'**
  String get reviewYourOrder;

  /// No description provided for @deliverySlot.
  ///
  /// In en, this message translates to:
  /// **'Delivery Slot'**
  String get deliverySlot;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @addAPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add A Payment Method'**
  String get addAPaymentMethod;

  /// No description provided for @changeYourPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Change Your Payment Method'**
  String get changeYourPaymentMethod;

  /// No description provided for @addNewCard.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get addNewCard;

  /// No description provided for @enterCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Coupon Code'**
  String get enterCouponCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @asSoonAsPossible.
  ///
  /// In en, this message translates to:
  /// **'As soon as possible within 2 hours'**
  String get asSoonAsPossible;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @addressTitle.
  ///
  /// In en, this message translates to:
  /// **'Address Title'**
  String get addressTitle;

  /// No description provided for @addressTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter address title'**
  String get addressTitleHint;

  /// No description provided for @shouldBeNumber.
  ///
  /// In en, this message translates to:
  /// **'Should be number'**
  String get shouldBeNumber;

  /// No description provided for @orderedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Ordered Successfully'**
  String get orderedSuccessfully;

  /// No description provided for @orderAmount.
  ///
  /// In en, this message translates to:
  /// **'Order Amount'**
  String get orderAmount;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @keepShopping.
  ///
  /// In en, this message translates to:
  /// **'Keep Shopping'**
  String get keepShopping;

  /// No description provided for @badResponse.
  ///
  /// In en, this message translates to:
  /// **'Bad Response'**
  String get badResponse;

  /// No description provided for @itemsInYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Items in your order'**
  String get itemsInYourOrder;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @cardEndingIn.
  ///
  /// In en, this message translates to:
  /// **'Card ending in'**
  String get cardEndingIn;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @saveCardForFutureOrders.
  ///
  /// In en, this message translates to:
  /// **'Save card for future orders'**
  String get saveCardForFutureOrders;

  /// No description provided for @notificationsSettings.
  ///
  /// In en, this message translates to:
  /// **'Notifications Settings'**
  String get notificationsSettings;

  /// No description provided for @activateMarketingNotifications.
  ///
  /// In en, this message translates to:
  /// **'Activate Marketing and Promotional Notifications'**
  String get activateMarketingNotifications;

  /// No description provided for @timeToUpdate.
  ///
  /// In en, this message translates to:
  /// **'Time To Update!'**
  String get timeToUpdate;

  /// No description provided for @newVersion.
  ///
  /// In en, this message translates to:
  /// **'New Version'**
  String get newVersion;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'NOT NOW'**
  String get notNow;

  /// No description provided for @timeSlot.
  ///
  /// In en, this message translates to:
  /// **'Time slot'**
  String get timeSlot;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @cartEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added anything to your cart yet'**
  String get cartEmptyDesc;

  /// No description provided for @returnToShop.
  ///
  /// In en, this message translates to:
  /// **'Return To Shop'**
  String get returnToShop;

  /// No description provided for @cartUnathorizedDesc.
  ///
  /// In en, this message translates to:
  /// **'To proceed, please sign in or create an account'**
  String get cartUnathorizedDesc;

  /// No description provided for @activeSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Active Subscriptions'**
  String get activeSubscriptions;

  /// No description provided for @productLabels.
  ///
  /// In en, this message translates to:
  /// **'Product Labels'**
  String get productLabels;

  /// No description provided for @endingOn.
  ///
  /// In en, this message translates to:
  /// **'Ending on'**
  String get endingOn;

  /// No description provided for @customersAlsoBought.
  ///
  /// In en, this message translates to:
  /// **'Customers Also Bought'**
  String get customersAlsoBought;

  /// No description provided for @recommendations.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendations;

  /// No description provided for @recentlyViewed.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get recentlyViewed;

  /// No description provided for @frequentlyBoughtTogether.
  ///
  /// In en, this message translates to:
  /// **'FREQUENTLY BOUGHT TOGETHER'**
  String get frequentlyBoughtTogether;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @noActiveSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'No Active subscriptions'**
  String get noActiveSubscriptions;

  /// No description provided for @availableSoon.
  ///
  /// In en, this message translates to:
  /// **'Available Soon'**
  String get availableSoon;

  /// No description provided for @noPastOrders.
  ///
  /// In en, this message translates to:
  /// **'No Past Orders'**
  String get noPastOrders;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// No description provided for @theseItemsAreNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Some items in your cart are now unavailable due to your location change. Please review your cart'**
  String get theseItemsAreNotAvailable;

  /// No description provided for @onlineChat.
  ///
  /// In en, this message translates to:
  /// **'Online Chat'**
  String get onlineChat;

  /// No description provided for @noDatesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No dates available'**
  String get noDatesAvailable;

  /// No description provided for @freiendlyErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong! Please contact our customer support.'**
  String get freiendlyErrorMessage;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @nearestTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'NEAREST TIMESLOT'**
  String get nearestTimeSlot;

  /// No description provided for @nearestTimeSlotDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'ve automatically set the earliest delivery time slot for you. If you prefer a different delivery time, No worries! You can easily change it on the checkout page!'**
  String get nearestTimeSlotDescription;

  /// No description provided for @proceedToCheckoutDescription.
  ///
  /// In en, this message translates to:
  /// **'By clicking on Proceed, you will be directed to checkout page, where you can select your delivery address, payment options, delivery time.'**
  String get proceedToCheckoutDescription;

  /// No description provided for @paymentMethodDescription.
  ///
  /// In en, this message translates to:
  /// **'By clicking on Change, you can change your payment method. Once you\'ve found a suitable option, you can select it!'**
  String get paymentMethodDescription;

  /// No description provided for @timeSlotChangerDescription.
  ///
  /// In en, this message translates to:
  /// **'Click here to select a different delivery time. A selection of available timeslots will be presented for you to choose from. Once you\'ve found a suitable option, click \'Select\' to update your delivery timeslot.'**
  String get timeSlotChangerDescription;

  /// No description provided for @widamWallet.
  ///
  /// In en, this message translates to:
  /// **'Widam Wallet'**
  String get widamWallet;

  /// No description provided for @openOrders.
  ///
  /// In en, this message translates to:
  /// **'Open Orders'**
  String get openOrders;

  /// No description provided for @reviewQuestion.
  ///
  /// In en, this message translates to:
  /// **'How was your order from\nWidam?'**
  String get reviewQuestion;

  /// No description provided for @orderReview.
  ///
  /// In en, this message translates to:
  /// **'Order Review'**
  String get orderReview;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @deliverySpeed.
  ///
  /// In en, this message translates to:
  /// **'Delivery Speed'**
  String get deliverySpeed;

  /// No description provided for @productQuality.
  ///
  /// In en, this message translates to:
  /// **'Product Quality'**
  String get productQuality;

  /// No description provided for @customerService.
  ///
  /// In en, this message translates to:
  /// **'Customer Service'**
  String get customerService;

  /// No description provided for @commentsAndFeedback.
  ///
  /// In en, this message translates to:
  /// **'Comments and Feedback'**
  String get commentsAndFeedback;

  /// No description provided for @yourComment.
  ///
  /// In en, this message translates to:
  /// **'Your Comment'**
  String get yourComment;

  /// No description provided for @writeYourCommentHere.
  ///
  /// In en, this message translates to:
  /// **'Write your comment here...'**
  String get writeYourCommentHere;

  /// No description provided for @pendingOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'My Ongoing Orders'**
  String get pendingOrderTitle;

  /// No description provided for @pendingOrderDescription.
  ///
  /// In en, this message translates to:
  /// **'Click to Track'**
  String get pendingOrderDescription;

  /// No description provided for @pastOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Past Orders'**
  String get pastOrdersTitle;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get trackOrder;

  /// No description provided for @widamWalletDescription.
  ///
  /// In en, this message translates to:
  /// **'Simplify your checkout experience with Widam wallet!'**
  String get widamWalletDescription;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @noTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'No Transaction History'**
  String get noTransactionHistory;

  /// No description provided for @widamPoints.
  ///
  /// In en, this message translates to:
  /// **'Widam Points'**
  String get widamPoints;

  /// No description provided for @widamLoyaltyProgram.
  ///
  /// In en, this message translates to:
  /// **'Widam Loyalty Program'**
  String get widamLoyaltyProgram;

  /// No description provided for @avaliablePoints.
  ///
  /// In en, this message translates to:
  /// **'Avaliable Points'**
  String get avaliablePoints;

  /// No description provided for @loyaltyPointsValue.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Points Value'**
  String get loyaltyPointsValue;

  /// No description provided for @pointsExpiringWithIn.
  ///
  /// In en, this message translates to:
  /// **'points expiring with in'**
  String get pointsExpiringWithIn;

  /// No description provided for @moreDetails.
  ///
  /// In en, this message translates to:
  /// **'More Details'**
  String get moreDetails;

  /// No description provided for @redeemYourPoints.
  ///
  /// In en, this message translates to:
  /// **'Redeem Your Points'**
  String get redeemYourPoints;

  /// No description provided for @learnAboutWidamPoints.
  ///
  /// In en, this message translates to:
  /// **'Learn about Widam points'**
  String get learnAboutWidamPoints;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @pointsHistory.
  ///
  /// In en, this message translates to:
  /// **'Points History'**
  String get pointsHistory;

  /// No description provided for @ordersUpdates.
  ///
  /// In en, this message translates to:
  /// **'Orders Updates'**
  String get ordersUpdates;

  /// No description provided for @totalEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Earned'**
  String get totalEarned;

  /// No description provided for @totalRedeemed.
  ///
  /// In en, this message translates to:
  /// **'Total Redeemed'**
  String get totalRedeemed;

  /// No description provided for @totalSaving.
  ///
  /// In en, this message translates to:
  /// **'Total Saving'**
  String get totalSaving;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get minimum;

  /// No description provided for @qar.
  ///
  /// In en, this message translates to:
  /// **'QAR'**
  String get qar;

  /// No description provided for @toUnlock.
  ///
  /// In en, this message translates to:
  /// **'to unlock'**
  String get toUnlock;

  /// No description provided for @redeemPointsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'You will redeem your points.'**
  String get redeemPointsConfirmation;

  /// No description provided for @chooseYourTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Choose your Timeslot:'**
  String get chooseYourTimeSlot;

  /// No description provided for @noProductsMatchingYourSelection.
  ///
  /// In en, this message translates to:
  /// **'No products matching your selection'**
  String get noProductsMatchingYourSelection;

  /// No description provided for @applyExistingOffer.
  ///
  /// In en, this message translates to:
  /// **'Apply existing offer:'**
  String get applyExistingOffer;

  /// No description provided for @salesInvoice.
  ///
  /// In en, this message translates to:
  /// **'Sales Invoice'**
  String get salesInvoice;

  /// No description provided for @loyaltyPointsRedeem.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Points Redeem'**
  String get loyaltyPointsRedeem;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @debit.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get debit;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @packageIsLoaded.
  ///
  /// In en, this message translates to:
  /// **'Package is Loaded'**
  String get packageIsLoaded;

  /// No description provided for @driverIsOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Driver is out for delivery'**
  String get driverIsOutForDelivery;

  /// No description provided for @contactDriver.
  ///
  /// In en, this message translates to:
  /// **'Contact Driver'**
  String get contactDriver;

  /// No description provided for @driverIsOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'Driver is On The Way'**
  String get driverIsOnTheWay;

  /// No description provided for @theOrderIsNearlyWithYou.
  ///
  /// In en, this message translates to:
  /// **'The order is nearly with you'**
  String get theOrderIsNearlyWithYou;

  /// No description provided for @orderIsDelivered.
  ///
  /// In en, this message translates to:
  /// **'Order is Delivered'**
  String get orderIsDelivered;

  /// No description provided for @salesOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'Sales Order Details'**
  String get salesOrderDetails;

  /// No description provided for @searchAllProducts.
  ///
  /// In en, this message translates to:
  /// **'Search all products'**
  String get searchAllProducts;

  /// No description provided for @refineYourSearch.
  ///
  /// In en, this message translates to:
  /// **'Refine your search'**
  String get refineYourSearch;

  /// No description provided for @searchDescription.
  ///
  /// In en, this message translates to:
  /// **'Search for any products in our catalog. Use Categories on the left vertical bar to filter your search.'**
  String get searchDescription;

  /// No description provided for @selectItemGroupDescription.
  ///
  /// In en, this message translates to:
  /// **'Select Category to filter your search per category. Change between categories to find the its subcategories and items.'**
  String get selectItemGroupDescription;

  /// No description provided for @autoOrder.
  ///
  /// In en, this message translates to:
  /// **'Auto-Order'**
  String get autoOrder;

  /// No description provided for @itIsEmptyHere.
  ///
  /// In en, this message translates to:
  /// **'It is empty here :('**
  String get itIsEmptyHere;

  /// No description provided for @noLoyaltyProgramDesc.
  ///
  /// In en, this message translates to:
  /// **'No loyalty program are available now. Please check back later or contact our customer support to activate your membership.'**
  String get noLoyaltyProgramDesc;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @describeYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Describe your address'**
  String get describeYourAddress;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'example: behind woqod station'**
  String get addressHint;

  /// No description provided for @minimumOrderAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum order amount'**
  String get minimumOrderAmount;

  /// No description provided for @addNewComplaint.
  ///
  /// In en, this message translates to:
  /// **'Add new complaint'**
  String get addNewComplaint;

  /// No description provided for @selectComplaintType.
  ///
  /// In en, this message translates to:
  /// **'Select Complaint Type'**
  String get selectComplaintType;

  /// No description provided for @technicalIssue.
  ///
  /// In en, this message translates to:
  /// **'Technical Issue'**
  String get technicalIssue;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @addComplaint.
  ///
  /// In en, this message translates to:
  /// **'Add Complaint'**
  String get addComplaint;

  /// No description provided for @writeDiscription.
  ///
  /// In en, this message translates to:
  /// **'Write Discription'**
  String get writeDiscription;

  /// No description provided for @widam.
  ///
  /// In en, this message translates to:
  /// **'Widam'**
  String get widam;

  /// No description provided for @slotterFeesValidationMsg.
  ///
  /// In en, this message translates to:
  /// **'Please select slotter fees'**
  String get slotterFeesValidationMsg;

  /// No description provided for @pickupPointsValidationMsg.
  ///
  /// In en, this message translates to:
  /// **'Please select a pickup point'**
  String get pickupPointsValidationMsg;

  /// No description provided for @coupons.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get coupons;

  /// No description provided for @couponNo.
  ///
  /// In en, this message translates to:
  /// **'Coupon No.'**
  String get couponNo;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @couponDetails.
  ///
  /// In en, this message translates to:
  /// **'Coupon Details'**
  String get couponDetails;

  /// No description provided for @scanCodeMsg.
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code to get your Adhia'**
  String get scanCodeMsg;

  /// No description provided for @pickupDetails.
  ///
  /// In en, this message translates to:
  /// **'Pickup Details'**
  String get pickupDetails;

  /// No description provided for @pickupTime.
  ///
  /// In en, this message translates to:
  /// **'Pickup Time'**
  String get pickupTime;

  /// No description provided for @pickupDate.
  ///
  /// In en, this message translates to:
  /// **'Pickup Date'**
  String get pickupDate;

  /// No description provided for @couponItems.
  ///
  /// In en, this message translates to:
  /// **'Coupon Items'**
  String get couponItems;

  /// No description provided for @goToLocation.
  ///
  /// In en, this message translates to:
  /// **'Go to location'**
  String get goToLocation;

  /// No description provided for @pickupTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Nearest\nPickup\nTime'**
  String get pickupTimeSlot;

  /// No description provided for @noCouponsYet.
  ///
  /// In en, this message translates to:
  /// **'No Coupons Yet'**
  String get noCouponsYet;

  /// No description provided for @merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get merge;

  /// No description provided for @expressPickup.
  ///
  /// In en, this message translates to:
  /// **'Express Pickup'**
  String get expressPickup;

  /// No description provided for @split.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get split;

  /// No description provided for @splitDescription.
  ///
  /// In en, this message translates to:
  /// **'Split cart for 2-hour delivery from your nearest warehouse.'**
  String get splitDescription;

  /// No description provided for @mergeDescription.
  ///
  /// In en, this message translates to:
  /// **'Make deliveries for all items from the main warehouse.'**
  String get mergeDescription;

  /// No description provided for @pickupDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick up your items from the nearest warehouse.'**
  String get pickupDescription;

  /// No description provided for @expressDescription.
  ///
  /// In en, this message translates to:
  /// **'Get express delivery for these items.'**
  String get expressDescription;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @firstEidDay.
  ///
  /// In en, this message translates to:
  /// **'First Day of Eid'**
  String get firstEidDay;

  /// No description provided for @secondEidDay.
  ///
  /// In en, this message translates to:
  /// **'Second Day of Eid'**
  String get secondEidDay;

  /// No description provided for @thirdEidDay.
  ///
  /// In en, this message translates to:
  /// **'Third Day of Eid'**
  String get thirdEidDay;

  /// No description provided for @fourthEidDay.
  ///
  /// In en, this message translates to:
  /// **'Fourth Day of Eid'**
  String get fourthEidDay;

  /// No description provided for @fifthEidDay.
  ///
  /// In en, this message translates to:
  /// **'Fifth Day of Eid'**
  String get fifthEidDay;

  /// No description provided for @sixthEidDay.
  ///
  /// In en, this message translates to:
  /// **'Sixth Day of Eid'**
  String get sixthEidDay;

  /// No description provided for @seventhEidDay.
  ///
  /// In en, this message translates to:
  /// **'Seventh Day of Eid'**
  String get seventhEidDay;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
