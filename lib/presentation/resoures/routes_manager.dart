import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/presentation/forget_password/view/forget_password_view.dart';
import 'package:clean_architecture/presentation/home/main_view.dart';
import 'package:clean_architecture/presentation/login/view/login_view.dart';
import 'package:clean_architecture/presentation/onBoarding/view/onBoarding_view.dart';
import 'package:clean_architecture/presentation/register/view/register_view.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/splash/splash_view.dart';
import 'package:clean_architecture/presentation/store_details/view/store_details_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forget_password";
  static const String homeRoute = "/home";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator{

  static Route<dynamic> getRoute(RouteSettings settings)
  {
    switch (settings.name)
    {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=>const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_)=>const ForgetPasswordView());
      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_)=>const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_)=>const StoreDetailsView());
      default:
        return unDefindedRoute();


    }
  }

  static Route<dynamic> unDefindedRoute()
  {
    return MaterialPageRoute(builder: (_)=> Scaffold(
      appBar: AppBar(
        title:  Text(AppStrings.noRouteFound.tr(),)
      ),
      body: Center(child: Text(AppStrings.noRouteFound.tr(),)),
    ));
  }
}