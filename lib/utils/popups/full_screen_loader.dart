import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/loaders/animation_loader.dart';
import '../../common/widgets/loaders/circular_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

/// Một lớp tiện ích để quản lý hộp thoại tải toàn màn hình.
class SHFFullScreenLoader {
  /// Mở một hộp thoại tải toàn màn hình với văn bản và hoạt ảnh đã cho.
  /// Phương thức này không trả về bất cứ điều gì.
  ///
  /// Tham số:
  /// - text: Văn bản sẽ được hiển thị trong hộp thoại tải.
  /// - animation: Hoạt ảnh Lottie sẽ được hiển thị.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Sử dụng Get.overlayContext cho các hộp thoại overlay
      barrierDismissible: false, // Hộp thoại không thể bị tắt bằng cách chạm ra ngoài nó
      builder: (_) => PopScope(
        canPop: false, // Vô hiệu hóa việc tắt bằng nút quay lại
        child: Container(
          color: SHFHelperFunctions.isDarkMode(Get.context!) ? SHFColors.dark : SHFColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Điều chỉnh khoảng cách nếu cần
              SHFAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void popUpCircular() {
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const SHFCircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  /// Dừng hộp thoại tải hiện đang mở.
  /// Phương thức này không trả về bất cứ điều gì.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Đóng hộp thoại bằng cách sử dụng Navigator
  }
}