import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/// Lớp tùy chỉnh cho Chủ đề Văn bản Sáng & Tối
class SHFCheckboxTheme {
  SHFCheckboxTheme._(); // Để tránh tạo thể hiện

  /// Chủ đề văn bản Sáng có thể tùy chỉnh
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SHFSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SHFColors.white;
      } else {
        return SHFColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SHFColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  /// Chủ đề văn bản Tối có thể tùy chỉnh
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SHFSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SHFColors.white;
      } else {
        return SHFColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SHFColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
