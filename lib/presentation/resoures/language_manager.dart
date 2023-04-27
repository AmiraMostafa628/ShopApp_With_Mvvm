import 'package:flutter/material.dart';

enum languageType {ENGLISH, ARABIC}

const String ENGLISH ="en";
const String ARABIC ="ar";
const String ASSETS_PATH_LOCALIZATIONS ="assets/translations";

const Locale LOCAL_ENGLISH = Locale("en","US");
const Locale LOCAL_ARABIC = Locale("ar","SA");

extension LanguageTypeExtension on languageType{
  String getValue()
  {
    switch(this) {
      case languageType.ENGLISH:
        return ENGLISH;
      case languageType.ARABIC:
        return ARABIC;
    }
  }

}

