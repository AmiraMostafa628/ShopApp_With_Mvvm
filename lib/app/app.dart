import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/presentation/resoures/routes_manager.dart';
import 'package:clean_architecture/presentation/resoures/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'di.dart';

class MyApp extends StatefulWidget {

   const MyApp._internal(); //named Constructor

  static const _instance =  MyApp._internal();
  factory MyApp()=> _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          theme: getAppTheme(),
        );
      }
    );
  }
}
