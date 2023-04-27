import 'package:clean_architecture/presentation/resoures/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String languageKey ="languageKey";
const String onBoardingViewedKey ="onBoardingViewedKey";
const String loggedInKey ="loggedInKey";


class AppPreferences{

  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);


  Future<String> getLanguage() async
  {
    String? language = _sharedPreferences.getString(languageKey);
    if(language != null && language.isNotEmpty)
      {
        return language;
      }
    else
      {
        return languageType.ENGLISH.getValue();
      }
  }

  Future<void> changeAppLanguage() async
  {
    String? currentLanguage= await getLanguage();
    if(currentLanguage == languageType.ARABIC.getValue())
      {
        // set language english
        _sharedPreferences.setString(languageKey, languageType.ENGLISH.getValue());
      }
    else
      {
        // set language arabic
        _sharedPreferences.setString(languageKey, languageType.ARABIC.getValue());
      }
   
  }

  Future<Locale> getLocal() async
  {
    String? currentLanguage= await getLanguage();
    if(currentLanguage == languageType.ARABIC.getValue())
    {
      return LOCAL_ARABIC;
    }
    else
    {
      return LOCAL_ENGLISH;
    }

  }

  Future<void> setOnBoardingViewed() async{
    _sharedPreferences.setBool(onBoardingViewedKey, true);
  }

  Future<bool> getOnBoardingViewed() async{
    return _sharedPreferences.getBool(onBoardingViewedKey)?? false;
  }

  Future<void> setIsUserLoggedIn() async{
    _sharedPreferences.setBool(loggedInKey, true);
  }

  Future<bool> getIsUserLoggedIn() async{
    return _sharedPreferences.getBool(loggedInKey)??false;
  }

  Future<void> logout() async{
    _sharedPreferences.remove(loggedInKey);
  }
}