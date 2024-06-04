import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Chủ đề Nút Nổi Sáng & Tối -- */
class SHFElevatedButtonTheme {
  SHFElevatedButtonTheme._(); // Để tránh tạo thể hiện


  /* -- Chủ đề Sáng -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: SHFColors.light,
      backgroundColor: SHFColors.primary,
      disabledForegroundColor: SHFColors.darkGrey,
      disabledBackgroundColor: SHFColors.buttonDisabled,
      side: const BorderSide(color: SHFColors.primary),
      padding: const EdgeInsets.symmetric(vertical: SHFSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.buttonRadius)),
      textStyle: const TextStyle(fontSize: 16, color: SHFColors.textWhite, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    ),
  );

  /* -- Chủ đề Tối -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: SHFColors.light,
      backgroundColor: SHFColors.primary,
      disabledForegroundColor: SHFColors.darkGrey,
      disabledBackgroundColor: SHFColors.darkerGrey,
      side: const BorderSide(color: SHFColors.primary),
      padding: const EdgeInsets.symmetric(vertical: SHFSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.buttonRadius)),
      textStyle: const TextStyle(fontSize: 16, color: SHFColors.textWhite, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    ),
  );
}
