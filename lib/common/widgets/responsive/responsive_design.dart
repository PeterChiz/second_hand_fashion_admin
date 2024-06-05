import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

/// Widget để hiển thị bố cục máy tính
class SHFResponsiveWidget extends StatelessWidget {
  const SHFResponsiveWidget({
    super.key,
    required this.desktop,
  });

  /// Widget cho bố cục máy tính
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= SHFSizes.desktopScreenSize) {
          return desktop;
        } else {
          return const SizedBox.shrink(); // Trả về một SizedBox rỗng nếu không phải bố cục máy tính
        }
      },
    );
  }
}