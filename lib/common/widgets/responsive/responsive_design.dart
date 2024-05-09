import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

/// Widget để hiển thị các bố cục khác nhau dựa trên kích thước màn hình
class SHFResponsiveWidget extends StatelessWidget {
  const SHFResponsiveWidget({super.key, required this.desktop, required this.tablet, required this.mobile});

  /// Widget cho bố cục máy tính
  final Widget desktop;

  /// Widget cho bố cục máy tính bảng
  final Widget tablet;

  /// Widget cho bố cục điện thoại di động
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= SHFSizes.desktopScreenSize) {
          return desktop;
        } else if (constraints.maxWidth < SHFSizes.desktopScreenSize && constraints.maxWidth >= SHFSizes.tabletScreenSize) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
