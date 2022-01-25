import 'package:flutter/cupertino.dart';

class AppLocale {
   Locale? locale;
  late String token;
   BuildContext? context;

  static  final AppLocale _singleton = AppLocale._internal();


  factory AppLocale() {
    return _singleton;
  }

  static AppLocale get singleton => _singleton;



  AppLocale._internal();
}
