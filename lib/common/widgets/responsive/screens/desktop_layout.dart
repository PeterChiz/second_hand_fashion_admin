import 'package:flutter/material.dart';
import '../../layouts/headers/header.dart';
import '../../layouts/sidebars/sidebar.dart';

/// Widget cho bố cục máy tính để bàn
class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body});

  /// Widget để hiển thị là phần thân của bố cục máy tính để bàn
  final Widget? body;

  /// Key cho scaffold widget
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Row(
        children: [
          const Expanded(child: SHFSidebar()), // Thanh bên
          Expanded(
            flex: 5,
            child: Column(
              children: [
                SHFHeader(scaffoldKey: scaffoldKey), // Đầu trang
                Expanded(child: body ?? Container()), // Phần thân
              ],
            ),
          ),
        ],
      ),
    );
  }
}
