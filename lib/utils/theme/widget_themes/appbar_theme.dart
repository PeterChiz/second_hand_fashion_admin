import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class SHFAppBarTheme{
  SHFAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: SHFColors.iconPrimary, size: SHFSizes.iconMd),
    actionsIconTheme: IconThemeData(color: SHFColors.iconPrimary, size: SHFSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: SHFColors.black, fontFamily: 'Urbanist'),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: SHFColors.dark,
    surfaceTintColor: SHFColors.dark,
    iconTheme: IconThemeData(color: SHFColors.black, size: SHFSizes.iconMd),
    actionsIconTheme: IconThemeData(color: SHFColors.white, size: SHFSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: SHFColors.white, fontFamily: 'Urbanist'),
  );
}