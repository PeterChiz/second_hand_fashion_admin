import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Chủ đề Nút Đường viền Sáng & Tối -- */
class SHFOutlinedButtonTheme {
  SHFOutlinedButtonTheme._(); // Để tránh tạo thể hiện


  /* -- Chủ đề Sáng -- */
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

  /* -- Chủ đề Tối -- */
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
