import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String Default_LANGUAGE = "language";

class DioHelper{
  AppPreferences _sharedPreferences;
  DioHelper(this._sharedPreferences);

  Future <Dio> init() async {
    Dio dio = Dio();

    String language = await _sharedPreferences.getLanguage();


    Map<String,String> headers={
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:Constants.token,
      Default_LANGUAGE:language,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.apiTimeOut,
      sendTimeout: Constants.apiTimeOut,
      receiveDataWhenStatusError: true,
    );

    if(!kReleaseMode)
      {
        dio.interceptors.add(PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true
        ));
      }

    return dio;
  }
}