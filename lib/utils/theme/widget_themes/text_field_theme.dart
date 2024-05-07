import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class SHFTextFormFieldTheme {
  SHFTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SHFColors.darkGrey,
    suffixIconColor: SHFColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: SHFSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SHFSizes.fontSizeMd, color: SHFColors.textPrimary, fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(fontSize: SHFSizes.fonSHFSizesm, color: SHFColors.textSecondary, fontFamily: 'Urbanist'),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle().copyWith(color: SHFColors.textSecondary, fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.borderPrimary),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SHFColors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: SHFColors.darkGrey,
    suffixIconColor: SHFColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: SHFSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SHFSizes.fontSizeMd, color: SHFColors.white, fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(fontSize: SHFSizes.fonSHFSizesm, color: SHFColors.white, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle().copyWith(color: SHFColors.white.withOpacity(0.8), fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SHFColors.error),
    ),
  );
}
