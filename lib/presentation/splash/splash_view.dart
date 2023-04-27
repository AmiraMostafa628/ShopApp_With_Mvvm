import 'dart:async';

import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/constant_Manager.dart';
import 'package:clean_architecture/presentation/resoures/routes_manager.dart';
import 'package:flutter/material.dart';

import '../resoures/assets_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences =instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async{
    _appPreferences.getIsUserLoggedIn().then((value) {
      if(value)
        {
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        }
      else
        {
          _appPreferences.getOnBoardingViewed().then((value){
            if(value)
              {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              }
            else
              {
                Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
              }
          });
        }

    });

  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
      const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
    }

    @override
    void dispose() {
      super.dispose();
      _timer?.cancel();

    }
  }