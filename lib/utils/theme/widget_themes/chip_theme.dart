import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SHFChipTheme {
  SHFChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: SHFColors.white,
    selectedColor: SHFColors.primary,
    disabledColor: SHFColors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: SHFColors.black, fontFamily: 'Urbanist'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: SHFColors.white,
    selectedColor: SHFColors.primary,
    disabledColor: SHFColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: SHFColors.white, fontFamily: 'Urbanist'),
  );
}
