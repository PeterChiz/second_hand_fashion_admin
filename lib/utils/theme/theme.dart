import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../theme/widget_themes/appbar_theme.dart';
import '../theme/widget_themes/bottom_sheet_theme.dart';
import '../theme/widget_themes/checkbox_theme.dart';
import '../theme/widget_themes/chip_theme.dart';
import '../theme/widget_themes/elevated_button_theme.dart';
import '../theme/widget_themes/outlined_button_theme.dart';
import '../theme/widget_themes/text_field_theme.dart';
import '../theme/widget_themes/text_theme.dart';

class SHFAppTheme {
  SHFAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    disabledColor: SHFColors.grey,
    brightness: Brightness.light,
    primaryColor: SHFColors.primary,
    textTheme: SHFTextTheme.lightTextTheme,
    chipTheme: SHFChipTheme.lightChipTheme,
    appBarTheme: SHFAppBarTheme.lightAppBarTheme,
    checkboxTheme: SHFCheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: SHFColors.primaryBackground,
    bottomSheetTheme: SHFBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SHFTElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SHFOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: SHFTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    disabledColor: SHFColors.grey,
    brightness: Brightness.dark,
    primaryColor: SHFColors.primary,
    textTheme: SHFTextTheme.darkTextTheme,
    chipTheme: SHFChipTheme.darkChipTheme,
    appBarTheme: SHFAppBarTheme.darkAppBarTheme,
    checkboxTheme: SHFCheckboxTheme.darkCheckboxTheme,
    scaffoldBackgroundColor: SHFColors.primary.withOpacity(0.1),
    bottomSheetTheme: SHFBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SHFTElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SHFOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: SHFTextFormFieldTheme.darkInputDecorationTheme,
  );
}
