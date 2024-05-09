import 'package:get/get.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/popups/loaders.dart';

/// Controller để quản lý trạng thái và chức năng của thanh bên
class SidebarController extends GetxController {
  /// Thể hiện của SidebarController
  static SidebarController instance = Get.find();

  /// Biến quan sát để theo dõi mục menu hoạt động
  final activeItem = SHFRoutes.dashboard.obs;

  /// Biến quan sát để theo dõi mục menu được di chuột qua
  final hoverItem = ''.obs;

  /// Thay đổi mục menu hoạt động
  void changeActiveItem(String route) => activeItem.value = route;

  /// Thay đổi mục menu được di chuột qua
  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  /// Kiểm tra xem một route có phải là mục menu hoạt động hay không
  bool isActive(String route) => activeItem.value == route;

  /// Kiểm tra xem một route có được di chuột qua hay không
  bool isHovering(String route) => hoverItem.value == route;

  /// Xử lý khi nhấp vào mục menu
  Future<void> menuOnTap(String route) async {
    try {
      if (!isActive(route)) {
        // Cập nhật Mục Menu Được Chọn
        changeActiveItem(route);

        // Nếu Menu Drawer mở trên Điện thoại, Đóng nó.
        if (SHFDeviceUtils.isMobileScreen(Get.context!)) Get.back();

        // Di chuyển đến màn hình khác HOẶC Đăng xuất
        if (route == 'logout') {
          await AuthenticationRepository.instance.logout();
        } else {
          Get.toNamed(route);
        }
      }
    } catch (e) {
      // Hiển thị thanh snack bar lỗi nếu có lỗi xảy ra
      SHFLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }
}
