import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

/// Controller for handling forget password functionality
class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Text editing controller for email field
  final email = TextEditingController();

  /// Form key for forget password form
  final forgetPasswordFormKey = GlobalKey<FormState>();

  /// Sends a password reset email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý yêu cầu của bạn...', SHFImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      SHFFullScreenLoader.stopLoading();

      // Redirect
      SHFLoaders.successSnackBar(title: 'Email đã gửi', message: 'Liên kết email được gửi để đặt lại mật khẩu của bạn'.tr);
      Get.offNamed(SHFRoutes.resetPassword,arguments: email.text.trim());
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Resends a password reset email
  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý yêu cầu của bạn...', SHFImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.trim());

      // Remove Loader
      SHFFullScreenLoader.stopLoading();

      // Show success message
      SHFLoaders.successSnackBar(title: 'Email đã gửi', message: 'Liên kết email được gửi để đặt lại mật khẩu của bạn'.tr);
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
