import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outline_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class SHFAppTheme{
  SHFAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: SHFColors.grey,
    brightness: Brightness.light,
    primaryColor: SHFColors.primary,
    textTheme: SHFTextTheme.lightTextTheme,
    chipTheme: SHFChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: SHFAppBarTheme.lightAppBarTheme,
    checkboxTheme: SHFCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SHFBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SHFElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SHFOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: SHFTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: SHFColors.grey,
    brightness: Brightness.dark,
    primaryColor: SHFColors.primary,
    textTheme: SHFTextTheme.darkTextTheme,
    chipTheme: SHFChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: SHFAppBarTheme.darkAppBarTheme,
    checkboxTheme: SHFCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: SHFBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SHFElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SHFOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: SHFTextFormFieldTheme.darkInputDecorationTheme,
  );
}