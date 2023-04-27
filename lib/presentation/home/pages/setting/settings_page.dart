import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/data/data_source/local_data_source.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/language_manager.dart';
import 'package:clean_architecture/presentation/resoures/routes_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retrofit/http.dart';
import 'dart:math' as math;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   final AppPreferences _appPreferences = instance<AppPreferences>();
   final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          children: [
            ListTile(
              leading: SvgPicture.asset(ImageAssets.changeLanguageIc),
              title: Text(AppStrings.changeLanguage.tr(),
                style: Theme.of(context).textTheme.bodyLarge,),
              trailing: Transform(
                alignment:  Alignment.center,
                transform: Matrix4.rotationY(isRtl()?math.pi:0),
                child:  SvgPicture.asset(ImageAssets.settingArrowIc),
              ),
              onTap: (){
                _changeLanguage();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.contactUsIc),
              title: Text(AppStrings.contactUs.tr(),
                style: Theme.of(context).textTheme.bodyLarge,),
              trailing:Transform(
                alignment:  Alignment.center,
                transform: Matrix4.rotationY(isRtl()?math.pi:0),
                child:  SvgPicture.asset(ImageAssets.settingArrowIc),
              ),
              onTap: (){
                _contactUs();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
              title: Text(AppStrings.inviteYourFriends.tr(),
                style: Theme.of(context).textTheme.bodyLarge,),
              trailing:Transform(
                alignment:  Alignment.center,
                transform: Matrix4.rotationY(isRtl()?math.pi:0),
                child:  SvgPicture.asset(ImageAssets.settingArrowIc),
              ),
              onTap: (){
                _inviteFriends();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.logoutIc),
              title: Text(AppStrings.logout.tr(),
                style: Theme.of(context).textTheme.bodyLarge,),
              trailing: Transform(
                alignment:  Alignment.center,
                transform: Matrix4.rotationY(isRtl()?math.pi:0),
                child:   SvgPicture.asset(ImageAssets.settingArrowIc),
              ),
              onTap: (){
                _logout();
              },
            ),
          ],
        )
    );
  }

  bool isRtl()
  {
    return context.locale == LOCAL_ARABIC;
  }

  _changeLanguage(){
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }
  _contactUs(){}
  _inviteFriends(){}


  _logout(){
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
