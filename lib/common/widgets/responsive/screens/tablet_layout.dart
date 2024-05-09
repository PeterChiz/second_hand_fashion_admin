import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';
import '../../layouts/sidebars/sidebar.dart';

/// Widget cho bố cục máy tính bảng
class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});

  /// Widget để hiển thị là phần thân của bố cục máy tính bảng
  final Widget? body;

  /// Key cho scaffold widget
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SHFSidebar(), // Thanh bên
      appBar: SHFHeader(scaffoldKey: scaffoldKey), // Đầu trang
      body: body ?? Container(), // Phần thân
    );
  }
}
