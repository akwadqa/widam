// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Widam`
  String get appTitle {
    return Intl.message(
      'Widam',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Deals`
  String get deals {
    return Intl.message(
      'Deals',
      name: 'deals',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Earliest\nDelivery`
  String get earliestDelivery {
    return Intl.message(
      'Earliest\nDelivery',
      name: 'earliestDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Search for any product`
  String get searchForAnyProduct {
    return Intl.message(
      'Search for any product',
      name: 'searchForAnyProduct',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Order Again`
  String get orderAgain {
    return Intl.message(
      'Order Again',
      name: 'orderAgain',
      desc: '',
      args: [],
    );
  }

  /// `Express Delivery`
  String get expressDelivery {
    return Intl.message(
      'Express Delivery',
      name: 'expressDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Choose your location`
  String get chooseYourLocation {
    return Intl.message(
      'Choose your location',
      name: 'chooseYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Enter location name`
  String get enterLocationName {
    return Intl.message(
      'Enter location name',
      name: 'enterLocationName',
      desc: '',
      args: [],
    );
  }

  /// `Locate Me`
  String get locateMe {
    return Intl.message(
      'Locate Me',
      name: 'locateMe',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRM LOCATION`
  String get confirmLocation {
    return Intl.message(
      'CONFIRM LOCATION',
      name: 'confirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Enable location service so we know where to drop your order`
  String get locationEnableMessage {
    return Intl.message(
      'Enable location service so we know where to drop your order',
      name: 'locationEnableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `View All Categories`
  String get viewAllCategories {
    return Intl.message(
      'View All Categories',
      name: 'viewAllCategories',
      desc: '',
      args: [],
    );
  }

  /// `Express`
  String get express {
    return Intl.message(
      'Express',
      name: 'express',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Enter your \nmobile number!`
  String get enterYourMobileNumber {
    return Intl.message(
      'Enter your \nmobile number!',
      name: 'enterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number to register or to\nsign-in to your existing account, we will send verification code!`
  String get loginDes {
    return Intl.message(
      'Please enter your phone number to register or to\nsign-in to your existing account, we will send verification code!',
      name: 'loginDes',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile no.`
  String get enterYourMobileNo {
    return Intl.message(
      'Enter your mobile no.',
      name: 'enterYourMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Must be 8 digits`
  String get mustBeEightDigits {
    return Intl.message(
      'Must be 8 digits',
      name: 'mustBeEightDigits',
      desc: '',
      args: [],
    );
  }

  /// `Qatari phone number must start with 3, 5, 6, or 7`
  String get qatariPhoneNumberValidator {
    return Intl.message(
      'Qatari phone number must start with 3, 5, 6, or 7',
      name: 'qatariPhoneNumberValidator',
      desc: '',
      args: [],
    );
  }

  /// `Price High to Low`
  String get priceHighToLow {
    return Intl.message(
      'Price High to Low',
      name: 'priceHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `Price Low to High`
  String get priceLowToHigh {
    return Intl.message(
      'Price Low to High',
      name: 'priceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `Name A to Z`
  String get nameAtoZ {
    return Intl.message(
      'Name A to Z',
      name: 'nameAtoZ',
      desc: '',
      args: [],
    );
  }

  /// `Name Z to A`
  String get nameZtoA {
    return Intl.message(
      'Name Z to A',
      name: 'nameZtoA',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get bestSeller {
    return Intl.message(
      'Best Seller',
      name: 'bestSeller',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verificationCode {
    return Intl.message(
      'Verification code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Hello Again!\nLet's verify your number.`
  String get otpHeaderTitle {
    return Intl.message(
      'Hello Again!\nLet\'s verify your number.',
      name: 'otpHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `We've sent you a code. Please enter the received code to proceed.`
  String get otpHeaderDes {
    return Intl.message(
      'We\'ve sent you a code. Please enter the received code to proceed.',
      name: 'otpHeaderDes',
      desc: '',
      args: [],
    );
  }

  /// `Don't receive the code?`
  String get dontReceiveTheCode {
    return Intl.message(
      'Don\'t receive the code?',
      name: 'dontReceiveTheCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend my code`
  String get resendMyCode {
    return Intl.message(
      'Resend my code',
      name: 'resendMyCode',
      desc: '',
      args: [],
    );
  }

  /// `You have`
  String get youHave {
    return Intl.message(
      'You have',
      name: 'youHave',
      desc: '',
      args: [],
    );
  }

  /// `attempts left`
  String get attemptsLeft {
    return Intl.message(
      'attempts left',
      name: 'attemptsLeft',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Should be 6 digits`
  String get otpMinLength {
    return Intl.message(
      'Should be 6 digits',
      name: 'otpMinLength',
      desc: '',
      args: [],
    );
  }

  /// `New account!`
  String get newAccount {
    return Intl.message(
      'New account!',
      name: 'newAccount',
      desc: '',
      args: [],
    );
  }

  /// `No account linked to your phone number. We'll create a new one using this number`
  String get newAccountDesc {
    return Intl.message(
      'No account linked to your phone number. We\'ll create a new one using this number',
      name: 'newAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Mr.`
  String get mr {
    return Intl.message(
      'Mr.',
      name: 'mr',
      desc: '',
      args: [],
    );
  }

  /// `Mrs.`
  String get mrs {
    return Intl.message(
      'Mrs.',
      name: 'mrs',
      desc: '',
      args: [],
    );
  }

  /// `Miss/Ms.`
  String get missOrMs {
    return Intl.message(
      'Miss/Ms.',
      name: 'missOrMs',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get firstNameHint {
    return Intl.message(
      'Enter your first name',
      name: 'firstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get lastNameHint {
    return Intl.message(
      'Enter your last name',
      name: 'lastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email (optional)`
  String get emailHint {
    return Intl.message(
      'Enter your email (optional)',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Pick your date of birth`
  String get dateOfBirthHint {
    return Intl.message(
      'Pick your date of birth',
      name: 'dateOfBirthHint',
      desc: '',
      args: [],
    );
  }

  /// `I have read and agree to the`
  String get termAndConditionsPrefix {
    return Intl.message(
      'I have read and agree to the',
      name: 'termAndConditionsPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Select Your\nProducts`
  String get selectYourProducts {
    return Intl.message(
      'Select Your\nProducts',
      name: 'selectYourProducts',
      desc: '',
      args: [],
    );
  }

  /// `Set Your\nSchedule`
  String get setYourSchedule {
    return Intl.message(
      'Set Your\nSchedule',
      name: 'setYourSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Review \n& confirm`
  String get reviewAndConfirm {
    return Intl.message(
      'Review \n& confirm',
      name: 'reviewAndConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Choose your schedule`
  String get chooseYourSchedule {
    return Intl.message(
      'Choose your schedule',
      name: 'chooseYourSchedule',
      desc: '',
      args: [],
    );
  }

  /// `We deliver your product every day/ week/ month `
  String get chooseYourScheduleDescription {
    return Intl.message(
      'We deliver your product every day/ week/ month ',
      name: 'chooseYourScheduleDescription',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Select Options`
  String get selectOptions {
    return Intl.message(
      'Select Options',
      name: 'selectOptions',
      desc: '',
      args: [],
    );
  }

  /// `Set up your plan`
  String get setUpYourPlan {
    return Intl.message(
      'Set up your plan',
      name: 'setUpYourPlan',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe`
  String get unsubscribe {
    return Intl.message(
      'Unsubscribe',
      name: 'unsubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Bi Weekly`
  String get biWeekly {
    return Intl.message(
      'Bi Weekly',
      name: 'biWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Bi Monthly`
  String get biMonthly {
    return Intl.message(
      'Bi Monthly',
      name: 'biMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Subscription starts on`
  String get subscriptionStartsOn {
    return Intl.message(
      'Subscription starts on',
      name: 'subscriptionStartsOn',
      desc: '',
      args: [],
    );
  }

  /// `Subscription ends on`
  String get subscriptionEndsOn {
    return Intl.message(
      'Subscription ends on',
      name: 'subscriptionEndsOn',
      desc: '',
      args: [],
    );
  }

  /// `Pick your time slot`
  String get pickYouTimeSlot {
    return Intl.message(
      'Pick your time slot',
      name: 'pickYouTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message(
      'Proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Edit The Title`
  String get editTitle {
    return Intl.message(
      'Edit The Title',
      name: 'editTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new title`
  String get enterAnewTitle {
    return Intl.message(
      'Enter a new title',
      name: 'enterAnewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription`
  String get yourSubscription {
    return Intl.message(
      'Your subscription',
      name: 'yourSubscription',
      desc: '',
      args: [],
    );
  }

  /// `is ready for submission!`
  String get isReadyForSubmission {
    return Intl.message(
      'is ready for submission!',
      name: 'isReadyForSubmission',
      desc: '',
      args: [],
    );
  }

  /// `We'll send you a notification prior to your\nnext scheduled delivery.`
  String get subscriptionDescription {
    return Intl.message(
      'We\'ll send you a notification prior to your\nnext scheduled delivery.',
      name: 'subscriptionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Details`
  String get subscriptionDetails {
    return Intl.message(
      'Subscription Details',
      name: 'subscriptionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get frequency {
    return Intl.message(
      'Frequency',
      name: 'frequency',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get specifications {
    return Intl.message(
      'Specifications',
      name: 'specifications',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Must be 11 digits`
  String get mustBeElevenDigits {
    return Intl.message(
      'Must be 11 digits',
      name: 'mustBeElevenDigits',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pickImage {
    return Intl.message(
      'Pick Image',
      name: 'pickImage',
      desc: '',
      args: [],
    );
  }

  /// `Please select image source`
  String get pleaseSelectImageSource {
    return Intl.message(
      'Please select image source',
      name: 'pleaseSelectImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `QID attached`
  String get qidAttached {
    return Intl.message(
      'QID attached',
      name: 'qidAttached',
      desc: '',
      args: [],
    );
  }

  /// `This ID has been validated successfully!`
  String get qidValidMessage {
    return Intl.message(
      'This ID has been validated successfully!',
      name: 'qidValidMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this ID is incorrect :(`
  String get qidInvalidMessage {
    return Intl.message(
      'Sorry, this ID is incorrect :(',
      name: 'qidInvalidMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please validate your ID`
  String get validateButtonMessage {
    return Intl.message(
      'Please validate your ID',
      name: 'validateButtonMessage',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Nice to meet you`
  String get profileGreetings {
    return Intl.message(
      'Hello! Nice to meet you',
      name: 'profileGreetings',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the destination for all your fresh needs, tailored for families in Qatar.`
  String get profileGreetingsDescription {
    return Intl.message(
      'Welcome to the destination for all your fresh needs, tailored for families in Qatar.',
      name: 'profileGreetingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Login Or Register`
  String get loginOrRegister {
    return Intl.message(
      'Login Or Register',
      name: 'loginOrRegister',
      desc: '',
      args: [],
    );
  }

  /// `Edit Your Profile`
  String get editYourProfile {
    return Intl.message(
      'Edit Your Profile',
      name: 'editYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get languageValue {
    return Intl.message(
      'العربية',
      name: 'languageValue',
      desc: '',
      args: [],
    );
  }

  /// `Request Error`
  String get requestError {
    return Intl.message(
      'Request Error',
      name: 'requestError',
      desc: '',
      args: [],
    );
  }

  /// `Bad Request`
  String get badRequest {
    return Intl.message(
      'Bad Request',
      name: 'badRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unprocessable Entity`
  String get unprocessableEntity {
    return Intl.message(
      'Unprocessable Entity',
      name: 'unprocessableEntity',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error`
  String get internalServerError {
    return Intl.message(
      'Internal Server Error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Conflict Connection`
  String get conflictConnection {
    return Intl.message(
      'Conflict Connection',
      name: 'conflictConnection',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get unauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get notFound {
    return Intl.message(
      'Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Deadline Exceeded`
  String get deadlineExceeded {
    return Intl.message(
      'Deadline Exceeded',
      name: 'deadlineExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Access Forbidden`
  String get accessForbidden {
    return Intl.message(
      'Access Forbidden',
      name: 'accessForbidden',
      desc: '',
      args: [],
    );
  }

  /// `Bad Certificate`
  String get badCertificate {
    return Intl.message(
      'Bad Certificate',
      name: 'badCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connectionError {
    return Intl.message(
      'Connection Error',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart Details`
  String get yourCartDetails {
    return Intl.message(
      'Your Cart Details',
      name: 'yourCartDetails',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Active\nSubscription`
  String get activeSubscription {
    return Intl.message(
      'Active\nSubscription',
      name: 'activeSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Past\nOrders`
  String get pastOrders {
    return Intl.message(
      'Past\nOrders',
      name: 'pastOrders',
      desc: '',
      args: [],
    );
  }

  /// `Your\nCoupons`
  String get yourCoupons {
    return Intl.message(
      'Your\nCoupons',
      name: 'yourCoupons',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Qatar`
  String get qatar {
    return Intl.message(
      'Qatar',
      name: 'qatar',
      desc: '',
      args: [],
    );
  }

  /// `Your Details`
  String get yourDetails {
    return Intl.message(
      'Your Details',
      name: 'yourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Reach out to us`
  String get reachOutToUs {
    return Intl.message(
      'Reach out to us',
      name: 'reachOutToUs',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Complaints`
  String get complaints {
    return Intl.message(
      'Complaints',
      name: 'complaints',
      desc: '',
      args: [],
    );
  }

  /// `2023 - Widam - all right reserved`
  String get allRightsReserved {
    return Intl.message(
      '2023 - Widam - all right reserved',
      name: 'allRightsReserved',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get myAccount {
    return Intl.message(
      'My Account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get myAddressees {
    return Intl.message(
      'My Addresses',
      name: 'myAddressees',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `You can edit your profile here. The mobile number associated with your account cannot be modified:`
  String get editProfileDesc {
    return Intl.message(
      'You can edit your profile here. The mobile number associated with your account cannot be modified:',
      name: 'editProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Account Deletion`
  String get accountDeletion {
    return Intl.message(
      'Account Deletion',
      name: 'accountDeletion',
      desc: '',
      args: [],
    );
  }

  /// `We're sorry to see you go, but we hope to see you again in the future!`
  String get accountDeletionDesc {
    return Intl.message(
      'We\'re sorry to see you go, but we hope to see you again in the future!',
      name: 'accountDeletionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete your account`
  String get deleteYourAccount {
    return Intl.message(
      'Delete your account',
      name: 'deleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charges`
  String get deliveryCharges {
    return Intl.message(
      'Delivery Charges',
      name: 'deliveryCharges',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `item`
  String get item {
    return Intl.message(
      'item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Change\nTime Slot`
  String get changeTimeSlot {
    return Intl.message(
      'Change\nTime Slot',
      name: 'changeTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `Opening Hours`
  String get openingHoures {
    return Intl.message(
      'Opening Hours',
      name: 'openingHoures',
      desc: '',
      args: [],
    );
  }

  /// `Pick-Up Location`
  String get pickupLocation {
    return Intl.message(
      'Pick-Up Location',
      name: 'pickupLocation',
      desc: '',
      args: [],
    );
  }

  /// `Order Total`
  String get orderTotal {
    return Intl.message(
      'Order Total',
      name: 'orderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Proceed To Checkout`
  String get proceedToCheckout {
    return Intl.message(
      'Proceed To Checkout',
      name: 'proceedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Select your delivery slot`
  String get selectYourDeliverySlot {
    return Intl.message(
      'Select your delivery slot',
      name: 'selectYourDeliverySlot',
      desc: '',
      args: [],
    );
  }

  /// `Fully Booked`
  String get fullyBooked {
    return Intl.message(
      'Fully Booked',
      name: 'fullyBooked',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `You have items added to your cart`
  String get youHaveItemsAddedToYourCart {
    return Intl.message(
      'You have items added to your cart',
      name: 'youHaveItemsAddedToYourCart',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `View Cart`
  String get viewCart {
    return Intl.message(
      'View Cart',
      name: 'viewCart',
      desc: '',
      args: [],
    );
  }

  /// `Your Addresses`
  String get yourAddresses {
    return Intl.message(
      'Your Addresses',
      name: 'yourAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Add new address`
  String get addNewAddress {
    return Intl.message(
      'Add new address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Existing Addresses`
  String get existingAddresses {
    return Intl.message(
      'Existing Addresses',
      name: 'existingAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Location Information`
  String get locationInformation {
    return Intl.message(
      'Location Information',
      name: 'locationInformation',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Address Details (Inwani)`
  String get addressDetails {
    return Intl.message(
      'Address Details (Inwani)',
      name: 'addressDetails',
      desc: '',
      args: [],
    );
  }

  /// `City Name`
  String get cityName {
    return Intl.message(
      'City Name',
      name: 'cityName',
      desc: '',
      args: [],
    );
  }

  /// `Select your city`
  String get cityNameHint {
    return Intl.message(
      'Select your city',
      name: 'cityNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Zone Number`
  String get zoneNumber {
    return Intl.message(
      'Zone Number',
      name: 'zoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select your zone`
  String get zoneNumberHint {
    return Intl.message(
      'Select your zone',
      name: 'zoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Area Name`
  String get areaName {
    return Intl.message(
      'Area Name',
      name: 'areaName',
      desc: '',
      args: [],
    );
  }

  /// `Select your area name`
  String get areaNameHint {
    return Intl.message(
      'Select your area name',
      name: 'areaNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Street No.`
  String get streetNo {
    return Intl.message(
      'Street No.',
      name: 'streetNo',
      desc: '',
      args: [],
    );
  }

  /// `Enter your street number`
  String get streetNoHint {
    return Intl.message(
      'Enter your street number',
      name: 'streetNoHint',
      desc: '',
      args: [],
    );
  }

  /// `Building No.`
  String get buildingNo {
    return Intl.message(
      'Building No.',
      name: 'buildingNo',
      desc: '',
      args: [],
    );
  }

  /// `Building or compound number`
  String get buildingNoHint {
    return Intl.message(
      'Building or compound number',
      name: 'buildingNoHint',
      desc: '',
      args: [],
    );
  }

  /// `Make This Default`
  String get makeThisDefault {
    return Intl.message(
      'Make This Default',
      name: 'makeThisDefault',
      desc: '',
      args: [],
    );
  }

  /// `Reciver Information`
  String get reciverInformation {
    return Intl.message(
      'Reciver Information',
      name: 'reciverInformation',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your full name`
  String get fullNameHint {
    return Intl.message(
      'Enter your full name',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No.`
  String get mobileNo {
    return Intl.message(
      'Mobile No.',
      name: 'mobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Address Label`
  String get addressLabel {
    return Intl.message(
      'Address Label',
      name: 'addressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Villa`
  String get villa {
    return Intl.message(
      'Villa',
      name: 'villa',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addAddress {
    return Intl.message(
      'Add Address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Update Address`
  String get updateAddress {
    return Intl.message(
      'Update Address',
      name: 'updateAddress',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Address`
  String get selectYourAddress {
    return Intl.message(
      'Select Your Address',
      name: 'selectYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Ship To`
  String get shipTo {
    return Intl.message(
      'Ship To',
      name: 'shipTo',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Apply Coupon`
  String get applyCoupon {
    return Intl.message(
      'Apply Coupon',
      name: 'applyCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Cart Total`
  String get cartTotal {
    return Intl.message(
      'Cart Total',
      name: 'cartTotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get deliveryFee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Service Fee`
  String get serviceFee {
    return Intl.message(
      'Service Fee',
      name: 'serviceFee',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Review Your Order`
  String get reviewYourOrder {
    return Intl.message(
      'Review Your Order',
      name: 'reviewYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Slot`
  String get deliverySlot {
    return Intl.message(
      'Delivery Slot',
      name: 'deliverySlot',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Add A Payment Method`
  String get addAPaymentMethod {
    return Intl.message(
      'Add A Payment Method',
      name: 'addAPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Change Your Payment Method`
  String get changeYourPaymentMethod {
    return Intl.message(
      'Change Your Payment Method',
      name: 'changeYourPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add New Card`
  String get addNewCard {
    return Intl.message(
      'Add New Card',
      name: 'addNewCard',
      desc: '',
      args: [],
    );
  }

  /// `Enter Coupon Code`
  String get enterCouponCode {
    return Intl.message(
      'Enter Coupon Code',
      name: 'enterCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `As soon as possible within 2 hours`
  String get asSoonAsPossible {
    return Intl.message(
      'As soon as possible within 2 hours',
      name: 'asSoonAsPossible',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Address Title`
  String get addressTitle {
    return Intl.message(
      'Address Title',
      name: 'addressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter address title`
  String get addressTitleHint {
    return Intl.message(
      'Enter address title',
      name: 'addressTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Should be number`
  String get shouldBeNumber {
    return Intl.message(
      'Should be number',
      name: 'shouldBeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Ordered Successfully`
  String get orderedSuccessfully {
    return Intl.message(
      'Ordered Successfully',
      name: 'orderedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Order Amount`
  String get orderAmount {
    return Intl.message(
      'Order Amount',
      name: 'orderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get orderNumber {
    return Intl.message(
      'Order Number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Keep Shopping`
  String get keepShopping {
    return Intl.message(
      'Keep Shopping',
      name: 'keepShopping',
      desc: '',
      args: [],
    );
  }

  /// `Bad Response`
  String get badResponse {
    return Intl.message(
      'Bad Response',
      name: 'badResponse',
      desc: '',
      args: [],
    );
  }

  /// `Items in your order`
  String get itemsInYourOrder {
    return Intl.message(
      'Items in your order',
      name: 'itemsInYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Card ending in`
  String get cardEndingIn {
    return Intl.message(
      'Card ending in',
      name: 'cardEndingIn',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Reorder`
  String get reorder {
    return Intl.message(
      'Reorder',
      name: 'reorder',
      desc: '',
      args: [],
    );
  }

  /// `Save card for future orders`
  String get saveCardForFutureOrders {
    return Intl.message(
      'Save card for future orders',
      name: 'saveCardForFutureOrders',
      desc: '',
      args: [],
    );
  }

  /// `Notifications Settings`
  String get notificationsSettings {
    return Intl.message(
      'Notifications Settings',
      name: 'notificationsSettings',
      desc: '',
      args: [],
    );
  }

  /// `Activate Marketing and Promotional Notifications`
  String get activateMarketingNotifications {
    return Intl.message(
      'Activate Marketing and Promotional Notifications',
      name: 'activateMarketingNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Time To Update!`
  String get timeToUpdate {
    return Intl.message(
      'Time To Update!',
      name: 'timeToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `New Version`
  String get newVersion {
    return Intl.message(
      'New Version',
      name: 'newVersion',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `NOT NOW`
  String get notNow {
    return Intl.message(
      'NOT NOW',
      name: 'notNow',
      desc: '',
      args: [],
    );
  }

  /// `Time slot`
  String get timeSlot {
    return Intl.message(
      'Time slot',
      name: 'timeSlot',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven't added anything to your cart yet`
  String get cartEmptyDesc {
    return Intl.message(
      'Looks like you haven\'t added anything to your cart yet',
      name: 'cartEmptyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Return To Shop`
  String get returnToShop {
    return Intl.message(
      'Return To Shop',
      name: 'returnToShop',
      desc: '',
      args: [],
    );
  }

  /// `To proceed, please sign in or create an account`
  String get cartUnathorizedDesc {
    return Intl.message(
      'To proceed, please sign in or create an account',
      name: 'cartUnathorizedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Active Subscriptions`
  String get activeSubscriptions {
    return Intl.message(
      'Active Subscriptions',
      name: 'activeSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Product Labels`
  String get productLabels {
    return Intl.message(
      'Product Labels',
      name: 'productLabels',
      desc: '',
      args: [],
    );
  }

  /// `Ending on`
  String get endingOn {
    return Intl.message(
      'Ending on',
      name: 'endingOn',
      desc: '',
      args: [],
    );
  }

  /// `Customers Also Bought`
  String get customersAlsoBought {
    return Intl.message(
      'Customers Also Bought',
      name: 'customersAlsoBought',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Recently Viewed`
  String get recentlyViewed {
    return Intl.message(
      'Recently Viewed',
      name: 'recentlyViewed',
      desc: '',
      args: [],
    );
  }

  /// `FREQUENTLY BOUGHT TOGETHER`
  String get frequentlyBoughtTogether {
    return Intl.message(
      'FREQUENTLY BOUGHT TOGETHER',
      name: 'frequentlyBoughtTogether',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `No Active subscriptions`
  String get noActiveSubscriptions {
    return Intl.message(
      'No Active subscriptions',
      name: 'noActiveSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Available Soon`
  String get availableSoon {
    return Intl.message(
      'Available Soon',
      name: 'availableSoon',
      desc: '',
      args: [],
    );
  }

  /// `No Past Orders`
  String get noPastOrders {
    return Intl.message(
      'No Past Orders',
      name: 'noPastOrders',
      desc: '',
      args: [],
    );
  }

  /// `Out of Stock`
  String get outOfStock {
    return Intl.message(
      'Out of Stock',
      name: 'outOfStock',
      desc: '',
      args: [],
    );
  }

  /// `Some items in your cart are now unavailable due to your location change. Please review your cart`
  String get theseItemsAreNotAvailable {
    return Intl.message(
      'Some items in your cart are now unavailable due to your location change. Please review your cart',
      name: 'theseItemsAreNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Online Chat`
  String get onlineChat {
    return Intl.message(
      'Online Chat',
      name: 'onlineChat',
      desc: '',
      args: [],
    );
  }

  /// `No dates available`
  String get noDatesAvailable {
    return Intl.message(
      'No dates available',
      name: 'noDatesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong! Please contact our customer support.`
  String get freiendlyErrorMessage {
    return Intl.message(
      'Something went wrong! Please contact our customer support.',
      name: 'freiendlyErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `NEAREST TIMESLOT`
  String get nearestTimeSlot {
    return Intl.message(
      'NEAREST TIMESLOT',
      name: 'nearestTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `We've automatically set the earliest delivery time slot for you. If you prefer a different delivery time, No worries! You can easily change it on the checkout page!`
  String get nearestTimeSlotDescription {
    return Intl.message(
      'We\'ve automatically set the earliest delivery time slot for you. If you prefer a different delivery time, No worries! You can easily change it on the checkout page!',
      name: 'nearestTimeSlotDescription',
      desc: '',
      args: [],
    );
  }

  /// `By clicking on Proceed, you will be directed to checkout page, where you can select your delivery address, payment options, delivery time.`
  String get proceedToCheckoutDescription {
    return Intl.message(
      'By clicking on Proceed, you will be directed to checkout page, where you can select your delivery address, payment options, delivery time.',
      name: 'proceedToCheckoutDescription',
      desc: '',
      args: [],
    );
  }

  /// `By clicking on Change, you can change your payment method. Once you've found a suitable option, you can select it!`
  String get paymentMethodDescription {
    return Intl.message(
      'By clicking on Change, you can change your payment method. Once you\'ve found a suitable option, you can select it!',
      name: 'paymentMethodDescription',
      desc: '',
      args: [],
    );
  }

  /// `Click here to select a different delivery time. A selection of available timeslots will be presented for you to choose from. Once you've found a suitable option, click 'Select' to update your delivery timeslot.`
  String get timeSlotChangerDescription {
    return Intl.message(
      'Click here to select a different delivery time. A selection of available timeslots will be presented for you to choose from. Once you\'ve found a suitable option, click \'Select\' to update your delivery timeslot.',
      name: 'timeSlotChangerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Widam Wallet`
  String get widamWallet {
    return Intl.message(
      'Widam Wallet',
      name: 'widamWallet',
      desc: '',
      args: [],
    );
  }

  /// `Open Orders`
  String get openOrders {
    return Intl.message(
      'Open Orders',
      name: 'openOrders',
      desc: '',
      args: [],
    );
  }

  /// `How was your order from\nWidam?`
  String get reviewQuestion {
    return Intl.message(
      'How was your order from\nWidam?',
      name: 'reviewQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Order Review`
  String get orderReview {
    return Intl.message(
      'Order Review',
      name: 'orderReview',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Speed`
  String get deliverySpeed {
    return Intl.message(
      'Delivery Speed',
      name: 'deliverySpeed',
      desc: '',
      args: [],
    );
  }

  /// `Product Quality`
  String get productQuality {
    return Intl.message(
      'Product Quality',
      name: 'productQuality',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get customerService {
    return Intl.message(
      'Customer Service',
      name: 'customerService',
      desc: '',
      args: [],
    );
  }

  /// `Comments and Feedback`
  String get commentsAndFeedback {
    return Intl.message(
      'Comments and Feedback',
      name: 'commentsAndFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Your Comment`
  String get yourComment {
    return Intl.message(
      'Your Comment',
      name: 'yourComment',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment here...`
  String get writeYourCommentHere {
    return Intl.message(
      'Write your comment here...',
      name: 'writeYourCommentHere',
      desc: '',
      args: [],
    );
  }

  /// `My Ongoing Orders`
  String get pendingOrderTitle {
    return Intl.message(
      'My Ongoing Orders',
      name: 'pendingOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Click to Track`
  String get pendingOrderDescription {
    return Intl.message(
      'Click to Track',
      name: 'pendingOrderDescription',
      desc: '',
      args: [],
    );
  }

  /// `Past Orders`
  String get pastOrdersTitle {
    return Intl.message(
      'Past Orders',
      name: 'pastOrdersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Track Order`
  String get trackOrder {
    return Intl.message(
      'Track Order',
      name: 'trackOrder',
      desc: '',
      args: [],
    );
  }

  /// `Simplify your checkout experience with Widam wallet!`
  String get widamWalletDescription {
    return Intl.message(
      'Simplify your checkout experience with Widam wallet!',
      name: 'widamWalletDescription',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transactionHistory {
    return Intl.message(
      'Transaction History',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `No Transaction History`
  String get noTransactionHistory {
    return Intl.message(
      'No Transaction History',
      name: 'noTransactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Widam Points`
  String get widamPoints {
    return Intl.message(
      'Widam Points',
      name: 'widamPoints',
      desc: '',
      args: [],
    );
  }

  /// `Widam Loyalty Program`
  String get widamLoyaltyProgram {
    return Intl.message(
      'Widam Loyalty Program',
      name: 'widamLoyaltyProgram',
      desc: '',
      args: [],
    );
  }

  /// `Avaliable Points`
  String get avaliablePoints {
    return Intl.message(
      'Avaliable Points',
      name: 'avaliablePoints',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty Points Value`
  String get loyaltyPointsValue {
    return Intl.message(
      'Loyalty Points Value',
      name: 'loyaltyPointsValue',
      desc: '',
      args: [],
    );
  }

  /// `points expiring with in`
  String get pointsExpiringWithIn {
    return Intl.message(
      'points expiring with in',
      name: 'pointsExpiringWithIn',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get moreDetails {
    return Intl.message(
      'More Details',
      name: 'moreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Your Points`
  String get redeemYourPoints {
    return Intl.message(
      'Redeem Your Points',
      name: 'redeemYourPoints',
      desc: '',
      args: [],
    );
  }

  /// `Learn about Widam points`
  String get learnAboutWidamPoints {
    return Intl.message(
      'Learn about Widam points',
      name: 'learnAboutWidamPoints',
      desc: '',
      args: [],
    );
  }

  /// `Learn More`
  String get learnMore {
    return Intl.message(
      'Learn More',
      name: 'learnMore',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `Redeem`
  String get redeem {
    return Intl.message(
      'Redeem',
      name: 'redeem',
      desc: '',
      args: [],
    );
  }

  /// `Points History`
  String get pointsHistory {
    return Intl.message(
      'Points History',
      name: 'pointsHistory',
      desc: '',
      args: [],
    );
  }

  /// `Orders Updates`
  String get ordersUpdates {
    return Intl.message(
      'Orders Updates',
      name: 'ordersUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Total Earned`
  String get totalEarned {
    return Intl.message(
      'Total Earned',
      name: 'totalEarned',
      desc: '',
      args: [],
    );
  }

  /// `Total Redeemed`
  String get totalRedeemed {
    return Intl.message(
      'Total Redeemed',
      name: 'totalRedeemed',
      desc: '',
      args: [],
    );
  }

  /// `Total Saving`
  String get totalSaving {
    return Intl.message(
      'Total Saving',
      name: 'totalSaving',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get minimum {
    return Intl.message(
      'Minimum',
      name: 'minimum',
      desc: '',
      args: [],
    );
  }

  /// `QAR`
  String get qar {
    return Intl.message(
      'QAR',
      name: 'qar',
      desc: '',
      args: [],
    );
  }

  /// `to unlock`
  String get toUnlock {
    return Intl.message(
      'to unlock',
      name: 'toUnlock',
      desc: '',
      args: [],
    );
  }

  /// `You will redeem your points.`
  String get redeemPointsConfirmation {
    return Intl.message(
      'You will redeem your points.',
      name: 'redeemPointsConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Choose your Timeslot:`
  String get chooseYourTimeSlot {
    return Intl.message(
      'Choose your Timeslot:',
      name: 'chooseYourTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `No products matching your selection`
  String get noProductsMatchingYourSelection {
    return Intl.message(
      'No products matching your selection',
      name: 'noProductsMatchingYourSelection',
      desc: '',
      args: [],
    );
  }

  /// `Apply existing offer:`
  String get applyExistingOffer {
    return Intl.message(
      'Apply existing offer:',
      name: 'applyExistingOffer',
      desc: '',
      args: [],
    );
  }

  /// `Sales Invoice`
  String get salesInvoice {
    return Intl.message(
      'Sales Invoice',
      name: 'salesInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty Points Redeem`
  String get loyaltyPointsRedeem {
    return Intl.message(
      'Loyalty Points Redeem',
      name: 'loyaltyPointsRedeem',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Debit`
  String get debit {
    return Intl.message(
      'Debit',
      name: 'debit',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Package is Loaded`
  String get packageIsLoaded {
    return Intl.message(
      'Package is Loaded',
      name: 'packageIsLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Driver is out for delivery`
  String get driverIsOutForDelivery {
    return Intl.message(
      'Driver is out for delivery',
      name: 'driverIsOutForDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Contact Driver`
  String get contactDriver {
    return Intl.message(
      'Contact Driver',
      name: 'contactDriver',
      desc: '',
      args: [],
    );
  }

  /// `Driver is On The Way`
  String get driverIsOnTheWay {
    return Intl.message(
      'Driver is On The Way',
      name: 'driverIsOnTheWay',
      desc: '',
      args: [],
    );
  }

  /// `The order is nearly with you`
  String get theOrderIsNearlyWithYou {
    return Intl.message(
      'The order is nearly with you',
      name: 'theOrderIsNearlyWithYou',
      desc: '',
      args: [],
    );
  }

  /// `Order is Delivered`
  String get orderIsDelivered {
    return Intl.message(
      'Order is Delivered',
      name: 'orderIsDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Sales Order Details`
  String get salesOrderDetails {
    return Intl.message(
      'Sales Order Details',
      name: 'salesOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Search all products`
  String get searchAllProducts {
    return Intl.message(
      'Search all products',
      name: 'searchAllProducts',
      desc: '',
      args: [],
    );
  }

  /// `Refine your search`
  String get refineYourSearch {
    return Intl.message(
      'Refine your search',
      name: 'refineYourSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search for any products in our catalog. Use Categories on the left vertical bar to filter your search.`
  String get searchDescription {
    return Intl.message(
      'Search for any products in our catalog. Use Categories on the left vertical bar to filter your search.',
      name: 'searchDescription',
      desc: '',
      args: [],
    );
  }

  /// `Select Category to filter your search per category. Change between categories to find the its subcategories and items.`
  String get selectItemGroupDescription {
    return Intl.message(
      'Select Category to filter your search per category. Change between categories to find the its subcategories and items.',
      name: 'selectItemGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Auto-Order`
  String get autoOrder {
    return Intl.message(
      'Auto-Order',
      name: 'autoOrder',
      desc: '',
      args: [],
    );
  }

  /// `It is empty here :(`
  String get itIsEmptyHere {
    return Intl.message(
      'It is empty here :(',
      name: 'itIsEmptyHere',
      desc: '',
      args: [],
    );
  }

  /// `No loyalty program are available now. Please check back later or contact our customer support to activate your membership.`
  String get noLoyaltyProgramDesc {
    return Intl.message(
      'No loyalty program are available now. Please check back later or contact our customer support to activate your membership.',
      name: 'noLoyaltyProgramDesc',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Describe your address`
  String get describeYourAddress {
    return Intl.message(
      'Describe your address',
      name: 'describeYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `example: behind woqod station`
  String get addressHint {
    return Intl.message(
      'example: behind woqod station',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order amount`
  String get minimumOrderAmount {
    return Intl.message(
      'Minimum order amount',
      name: 'minimumOrderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Add new complaint`
  String get addNewComplaint {
    return Intl.message(
      'Add new complaint',
      name: 'addNewComplaint',
      desc: '',
      args: [],
    );
  }

  /// `Select Complaint Type`
  String get selectComplaintType {
    return Intl.message(
      'Select Complaint Type',
      name: 'selectComplaintType',
      desc: '',
      args: [],
    );
  }

  /// `Technical Issue`
  String get technicalIssue {
    return Intl.message(
      'Technical Issue',
      name: 'technicalIssue',
      desc: '',
      args: [],
    );
  }

  /// `Complaint`
  String get complaint {
    return Intl.message(
      'Complaint',
      name: 'complaint',
      desc: '',
      args: [],
    );
  }

  /// `Add Complaint`
  String get addComplaint {
    return Intl.message(
      'Add Complaint',
      name: 'addComplaint',
      desc: '',
      args: [],
    );
  }

  /// `Write Discription`
  String get writeDiscription {
    return Intl.message(
      'Write Discription',
      name: 'writeDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Widam`
  String get widam {
    return Intl.message(
      'Widam',
      name: 'widam',
      desc: '',
      args: [],
    );
  }

  /// `Please select slotter fees`
  String get slotterFeesValidationMsg {
    return Intl.message(
      'Please select slotter fees',
      name: 'slotterFeesValidationMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please select a pickup point`
  String get pickupPointsValidationMsg {
    return Intl.message(
      'Please select a pickup point',
      name: 'pickupPointsValidationMsg',
      desc: '',
      args: [],
    );
  }

  /// `Coupons`
  String get coupons {
    return Intl.message(
      'Coupons',
      name: 'coupons',
      desc: '',
      args: [],
    );
  }

  /// `Coupon No.`
  String get couponNo {
    return Intl.message(
      'Coupon No.',
      name: 'couponNo',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Details`
  String get couponDetails {
    return Intl.message(
      'Coupon Details',
      name: 'couponDetails',
      desc: '',
      args: [],
    );
  }

  /// `Scan this QR code to get your Adhia`
  String get scanCodeMsg {
    return Intl.message(
      'Scan this QR code to get your Adhia',
      name: 'scanCodeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Details`
  String get pickupDetails {
    return Intl.message(
      'Pickup Details',
      name: 'pickupDetails',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Time`
  String get pickupTime {
    return Intl.message(
      'Pickup Time',
      name: 'pickupTime',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Date`
  String get pickupDate {
    return Intl.message(
      'Pickup Date',
      name: 'pickupDate',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Items`
  String get couponItems {
    return Intl.message(
      'Coupon Items',
      name: 'couponItems',
      desc: '',
      args: [],
    );
  }

  /// `Go to location`
  String get goToLocation {
    return Intl.message(
      'Go to location',
      name: 'goToLocation',
      desc: '',
      args: [],
    );
  }

  /// `Nearest\nPickup\nTime`
  String get pickupTimeSlot {
    return Intl.message(
      'Nearest\nPickup\nTime',
      name: 'pickupTimeSlot',
      desc: '',
      args: [],
    );
  }

  /// `No Coupons Yet`
  String get noCouponsYet {
    return Intl.message(
      'No Coupons Yet',
      name: 'noCouponsYet',
      desc: '',
      args: [],
    );
  }

  /// `Merge`
  String get merge {
    return Intl.message(
      'Merge',
      name: 'merge',
      desc: '',
      args: [],
    );
  }

  /// `Express Pickup`
  String get expressPickup {
    return Intl.message(
      'Express Pickup',
      name: 'expressPickup',
      desc: '',
      args: [],
    );
  }

  /// `Split`
  String get split {
    return Intl.message(
      'Split',
      name: 'split',
      desc: '',
      args: [],
    );
  }

  /// `Split cart for 2-hour delivery from your nearest warehouse.`
  String get splitDescription {
    return Intl.message(
      'Split cart for 2-hour delivery from your nearest warehouse.',
      name: 'splitDescription',
      desc: '',
      args: [],
    );
  }

  /// `Make deliveries for all items from the main warehouse.`
  String get mergeDescription {
    return Intl.message(
      'Make deliveries for all items from the main warehouse.',
      name: 'mergeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pick up your items from the nearest warehouse.`
  String get pickupDescription {
    return Intl.message(
      'Pick up your items from the nearest warehouse.',
      name: 'pickupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Get express delivery for these items.`
  String get expressDescription {
    return Intl.message(
      'Get express delivery for these items.',
      name: 'expressDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get pickup {
    return Intl.message(
      'Pickup',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
