import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  
  Locale _locale = const Locale('en');
  
  Locale get locale => _locale;
  
  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('sw'), // Kiswahili
  ];
  
  // Localized strings
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      // Language Selection Screen
      'choose_language': 'Choose Your Language',
      'chagua_lugha': 'Chagua Lugha Yako',
      
      // Onboarding Screen
      'welcome_to_freshcart': 'Welcome to Soko Mkononi',
      'discover_amazing_products': 'Discover amazing products and shop with ease',
      'fast_delivery': 'Fast Delivery',
      'get_orders_delivered': 'Get your orders delivered to your doorstep quickly',
      'secure_payments': 'Secure Payments',
      'shop_safely': 'Shop safely with our secure payment options',
      'get_started': 'Get Started',
      'skip': 'Skip',
      
      // Login Screen
      'welcome_back': 'Welcome Back!',
      'sign_in_to_continue': 'Sign in to continue shopping',
      'username_or_email': 'Username or Email',
      'enter_username_or_email': 'Enter your username or email',
      'password': 'Password',
      'enter_password': 'Enter your password',
      'forgot_password': 'Forgot Password?',
      'login': 'Login',
      'dont_have_account': 'Don\'t have an account? ',
      'sign_up': 'Sign Up',
      'terms_agreement': 'By continuing, you agree to our ',
      'terms_of_service': 'Terms of Service',
      'and': ' and ',
      'privacy_policy': 'Privacy Policy',
      'please_enter_username': 'Please enter your username or email',
      'please_enter_password': 'Please enter your password',
      
      // Signup Screen
      'create_account': 'Create Account',
      'join_us_today': 'Join us today and start shopping',
      'confirm_password': 'Confirm Password',
      'enter_confirm_password': 'Confirm your password',
      'already_have_account': 'Already have an account? ',
      'sign_in': 'Sign In',
      'passwords_dont_match': 'Passwords don\'t match',
      'please_enter_confirm_password': 'Please confirm your password',
      
      // Common
      'continue': 'Continue',
      'next': 'Next',
      'back': 'Back',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'done': 'Done',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'warning': 'Warning',
      'info': 'Information',
    },
    'sw': {
      // Language Selection Screen
      'choose_language': 'Chagua Lugha Yako',
      'chagua_lugha': 'Choose Your Language',
      
      // Onboarding Screen
      'welcome_to_freshcart': 'Karibu Soko Mkononi',
      'discover_amazing_products': 'Gundua bidhaa za kuvutia na nunua kwa urahisi',
      'fast_delivery': 'Uwasilishaji wa Haraka',
      'get_orders_delivered': 'Pata oda zako kuwasilishwa kwenye mlango wako haraka',
      'secure_payments': 'Malipo Salama',
      'shop_safely': 'Nunua kwa usalama na chaguzi zetu za malipo salama',
      'get_started': 'Anza',
      'skip': 'Ruka',
      
      // Login Screen
      'welcome_back': 'Karibu Tena!',
      'sign_in_to_continue': 'Ingia ili uendelee kununua',
      'username_or_email': 'Jina la Mtumiaji au Barua Pepe',
      'enter_username_or_email': 'Weka jina la mtumiaji au barua pepe yako',
      'password': 'Nywila',
      'enter_password': 'Weka nywila yako',
      'forgot_password': 'Umesahau Nywila?',
      'login': 'Ingia',
      'dont_have_account': 'Huna akaunti? ',
      'sign_up': 'Jisajili',
      'terms_agreement': 'Kwa kuendelea, unakubaliana na ',
      'terms_of_service': 'Sheria za Huduma',
      'and': ' na ',
      'privacy_policy': 'Sera ya Faragha',
      'please_enter_username': 'Tafadhali weka jina la mtumiaji au barua pepe yako',
      'please_enter_password': 'Tafadhali weka nywila yako',
      
      // Signup Screen
      'create_account': 'Unda Akaunti',
      'join_us_today': 'Jiunge nasi leo na uanze kununua',
      'confirm_password': 'Thibitisha Nywila',
      'enter_confirm_password': 'Thibitisha nywila yako',
      'already_have_account': 'Una akaunti tayari? ',
      'sign_in': 'Ingia',
      'passwords_dont_match': 'Nywila hazifanani',
      'please_enter_confirm_password': 'Tafadhali thibitisha nywila yako',
      
      // Common
      'continue': 'Endelea',
      'next': 'Ifuatayo',
      'back': 'Rudi Nyuma',
      'cancel': 'Ghairi',
      'save': 'Hifadhi',
      'delete': 'Futa',
      'edit': 'Hariri',
      'done': 'Imekamilika',
      'loading': 'Inapakia...',
      'error': 'Hitilafu',
      'success': 'Mafanikio',
      'warning': 'Onyo',
      'info': 'Maelezo',
    },
  };
  
  // Get localized string
  String getString(String key) {
    return _localizedStrings[_locale.languageCode]?[key] ?? 
           _localizedStrings['en']![key] ?? 
           key;
  }
  
  // Initialize locale from saved preference
  Future<void> initializeLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey);
    
    if (savedLanguage != null) {
      _locale = Locale(savedLanguage);
      notifyListeners();
    }
  }
  
  // Change locale
  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    
    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    
    notifyListeners();
  }
  
  // Get current language name
  String getCurrentLanguageName() {
    switch (_locale.languageCode) {
      case 'en':
        return 'English';
      case 'sw':
        return 'Kiswahili';
      default:
        return 'English';
    }
  }
}

// Global instance
final LocalizationService localizationService = LocalizationService(); 