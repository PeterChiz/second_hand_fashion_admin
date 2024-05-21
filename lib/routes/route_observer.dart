import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_admin/routes/routes.dart';

import '../common/widgets/layouts/sidebars/sidebar_controller.dart';

/// Một trình quan sát tùy chỉnh cho việc quản lý sự kiện điều hướng trong ứng dụng.
class RouteObservers extends GetObserver {

  /// Được gọi khi một route được loại bỏ khỏi ngăn xếp điều hướng.
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if (previousRoute != null) {
      // Kiểm tra tên route và cập nhật mục hoạt động trong thanh bên tương ứng
      for (var routeName in SHFRoutes.sideMenuItems) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }

  /// Được gọi khi một route được thêm vào ngăn xếp điều hướng.
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if (route != null) {
      // Kiểm tra tên route và cập nhật mục hoạt động trong thanh bên tương ứng
      for (var routeName in SHFRoutes.sideMenuItems) {
        if (route.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
}
