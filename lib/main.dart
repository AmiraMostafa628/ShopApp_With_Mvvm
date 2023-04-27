import 'package:clean_architecture/presentation/resoures/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';
import 'app/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await initAppModule();

  runApp(
    EasyLocalization(
        supportedLocales: const [LOCAL_ENGLISH,LOCAL_ARABIC],
        path: ASSETS_PATH_LOCALIZATIONS,
        child: Phoenix(child: MyApp(),)));
}



