import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/font_manager.dart';
import 'package:clean_architecture/presentation/resoures/style_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme()
{
  return ThemeData(
    //main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark:  ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary, // ripple effect Color

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      shadowColor: ColorManager.lightPrimary,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(fontSize:FontSize.s16,color: ColorManager.white),
    ),

     buttonTheme: ButtonThemeData(
       shape: const StadiumBorder(),
       disabledColor: ColorManager.grey1,
       buttonColor: ColorManager.primary,
       splashColor: ColorManager.lightPrimary,
     ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
       textStyle: getRegularStyle(fontSize:FontSize.s17,color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12)
        )
      ),
    ),

    textTheme: TextTheme(
      displayLarge:getSemiBoldStyle(fontSize:FontSize.s16,color: ColorManager.darkGrey) ,
      headlineMedium:getSemiBoldStyle(fontSize:FontSize.s14,color: ColorManager.darkGrey) ,
      titleMedium: getMediumStyle(fontSize:FontSize.s14,color: ColorManager.primary),
      titleSmall: getRegularStyle(fontSize:FontSize.s16,color: ColorManager.white),
      bodySmall: getRegularStyle(color: ColorManager.grey1),
      bodyLarge: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s16),
      bodyMedium: getRegularStyle(color: ColorManager.grey2,fontSize: AppSize.s14),
      labelSmall: getBoldStyle(fontSize:FontSize.s14,color: ColorManager.primary),
    ),

    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(fontSize:FontSize.s14,color: ColorManager.grey),
      labelStyle: getRegularStyle(fontSize:FontSize.s14,color: ColorManager.grey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(

        borderSide: BorderSide(
          color: ColorManager.lightGrey,
          width: AppSize.s1_5,

        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorManager.error,
            width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

      ),
    ),


  );
}