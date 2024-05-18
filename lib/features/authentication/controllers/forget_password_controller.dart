import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

/// Bộ điều khiển cho việc xử lý quên mật khẩu
class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Bộ điều khiển chỉnh sửa văn bản cho trường email
  final email = TextEditingController();

  /// Khóa form cho form quên mật khẩu
  final forgetPasswordFormKey = GlobalKey<FormState>();

  /// Gửi email đặt lại mật khẩu
  sendPasswordResetEmail() async {
    try {
      // Bắt đầu tải
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý yêu cầu của bạn...', SHFImages.docerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Xác thực form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Gửi email để đặt lại mật khẩu
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Dừng tải
      SHFFullScreenLoader.stopLoading();

      // Chuyển hướng
      SHFLoaders.successSnackBar(title: 'Email đã gửi', message: 'Liên kết email được gửi để đặt lại mật khẩu của bạn'.tr);
      Get.offNamed(SHFRoutes.resetPassword, arguments: email.text.trim());
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Gửi lại email đặt lại mật khẩu
  resendPasswordResetEmail(String email) async {
    try {
      // Bắt đầu tải
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý yêu cầu của bạn...', SHFImages.docerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Gửi email để đặt lại mật khẩu
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.trim());

      // Dừng tải
      SHFFullScreenLoader.stopLoading();

      // Hiển thị thông báo thành công
      SHFLoaders.successSnackBar(title: 'Email đã gửi', message: 'Liên kết email được gửi để đặt lại mật khẩu của bạn'.tr);
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
