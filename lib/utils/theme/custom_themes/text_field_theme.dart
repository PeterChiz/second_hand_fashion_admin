import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';


class SHFTextFormFieldTheme{
  SHFTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SHFColors.darkGrey,
    suffixIconColor: SHFColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: SHFSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SHFSizes.fontSizeMd, color: SHFColors.black, fontFamily: 'Poppins'),
    hintStyle: const TextStyle().copyWith(fontSize: SHFSizes.fontSizeSm, color: SHFColors.black, fontFamily: 'Poppins'),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, fontFamily: 'Poppins'),
    floatingLabelStyle: const TextStyle().copyWith(color: SHFColors.black.withOpacity(0.8), fontFamily: 'Poppins'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.grey),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SHFColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SHFColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: SHFColors.darkGrey,
    suffixIconColor: SHFColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: SHFSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SHFSizes.fontSizeMd, color: SHFColors.white, fontFamily: 'Poppins'),
    hintStyle: const TextStyle().copyWith(fontSize: SHFSizes.fontSizeSm, color: SHFColors.white, fontFamily: 'Poppins'),
    floatingLabelStyle: const TextStyle().copyWith(color: SHFColors.white.withOpacity(0.8), fontFamily: 'Poppins'),
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
      borderSide: const BorderSide(width: 1, color: SHFColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SHFSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SHFColors.warning),
    ),
  );
}