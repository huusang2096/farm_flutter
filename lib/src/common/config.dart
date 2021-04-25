import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simplest/simplest.dart';

export 'extensions.dart';
export 'resources.dart';
export 'style.dart';

const kAppName = 'FarmGate';
const String GOOGLE_BASE_URL = "https://maps.googleapis.com/maps/api/";
const String BASE_URL = "https://dev.farmgate.di4l.vn/";
const String IMAGE_BASE_URL = "https://dev.farmgate.di4l.vn/storage/";
const String apiKey =
    "AIzaSyA66KwUrjxcFG5u0exynlJ45CrbrNe3hEc"; // temporary key
const String BASE_URL_STORAGE = "https://glinkworkdev.di4l.vn/storage/";
const String language = 'vi';
const String region = 'VN';
const String locale = 'vi_VN';
const String CLIENT_ID = "2";
const String CLIENT_SECRET = "belaTTHPlUNjNAeSngXbeg1nLgxn47t7BXjIDEpz";
const String kCurrency = "đ";
const String kSupportNumber = '190';
const String URL_CATEGORY =
    "https://dev.farmgate.di4l.vn/api/v1/posts/filters?page=";

// Config Firebase
const String FIREBASE_DATABASE_NAME = "db2";
const String FIREBASE_IOS_ID = "1:838076439627:ios:969083fa91ad1f3a41c1ce";
const String FIREBASE_ANDROID_ID =
    "1:838076439627:android:a35732278750fc8f41c1ce";
const String FIREBASE_SENDER_ID = "838076439627";
const String FIREBASE_PROJECT_ID = "glinkwork-895be";
const String FIREBASE_URL = "https://glinkwork-895be.firebaseio.com/";
const String FIREBASE_KEY = "AIzaSyC_aXNLxic99I_ddVnNZFaWNWeWaMF1QU0";

final dateFormatter = new DateFormat('yyyy-MM-dd');
final dateVNFormatter = new DateFormat('dd-MM-yyyy');
final hourFormatter = new DateFormat('h:mm a');
final fullDateFormatter = new DateFormat.yMMMMEEEEd('vi_VN');
final dayFormatter = new DateFormat('dd/MM');
final actionDateFormatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');
final currencyformatterSymbol =
    new NumberFormat.simpleCurrency(locale: 'vi_VN');
final hourHMFormatter = DateFormat.Hm(locale); // 24 hour

const supportedLocales = [
  Locale('en'),
  Locale('vi'),
];
