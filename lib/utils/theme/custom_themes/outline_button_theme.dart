import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class SHFOutlinedButtonTheme {
  SHFOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SHFColors.dark,
      side: const BorderSide(color: SHFColors.borderPrimary),
      padding: const EdgeInsets.symmetric(vertical: SHFSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.buttonRadius)),
      textStyle: const TextStyle(fontSize: 16, color: SHFColors.black, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: SHFColors.light,
      side: const BorderSide(color: SHFColors.borderPrimary),
      padding: const EdgeInsets.symmetric(vertical: SHFSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.buttonRadius)),
      textStyle: const TextStyle(fontSize: 16, color: SHFColors.textWhite, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    ),
  );
}