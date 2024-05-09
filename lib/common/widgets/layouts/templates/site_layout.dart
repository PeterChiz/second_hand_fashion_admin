import 'package:flutter/material.dart';
import '../../responsive/responsive_design.dart';
import '../../responsive/screens/desktop_layout.dart';
import '../../responsive/screens/mobile_layout.dart';
import '../../responsive/screens/tablet_layout.dart';

/// Mẫu cho bố cục tổng thể của trang web, đáp ứng với các kích thước màn hình khác nhau
class SHFSiteTemplate extends StatelessWidget {
  const SHFSiteTemplate({super.key, this.desktop, this.tablet, this.mobile, this.useLayout = true});

  /// Tiện ích cho bố cục máy tính để bàn
  final Widget? desktop;

  /// Tiện ích cho bố cục máy tính bảng
  final Widget? tablet;

  /// Tiện ích cho bố cục di động
  final Widget? mobile;

  /// Cờ để xác định liệu có sử dụng bố cục hay không
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SHFResponsiveWidget(
        desktop: useLayout ? DesktopLayout(body: desktop) : desktop ?? Container(),
        tablet: useLayout ? TabletLayout(body: tablet ?? desktop) : tablet ?? desktop ?? Container(),
        mobile: useLayout ? MobileLayout(body: mobile ?? desktop) : mobile ?? desktop ?? Container(),
      ),
    );
  }
}
