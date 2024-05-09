import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';
import '../../layouts/sidebars/sidebar.dart';

/// Widget cho bố cục di động
class MobileLayout extends StatelessWidget {
  MobileLayout({
    super.key,
    this.body,
  });

  /// Widget sẽ được hiển thị như là phần thân của bố cục di động
  final Widget? body;

  /// Key cho scaffold widget
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SHFSidebar(), // Thanh bên
      appBar: SHFHeader(scaffoldKey: scaffoldKey), // Đầu trang
      body: body ?? Container(), // Thân
    );
  }
}
