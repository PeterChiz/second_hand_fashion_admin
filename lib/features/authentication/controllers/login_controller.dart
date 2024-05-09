import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/text_strings.dart';
import '../../personalization/models/user_model.dart';
import 'admin_controller.dart';

/// Bộ điều khiển để xử lý chức năng đăng nhập
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Dữ liệu đang tải
  final isLoading = false.obs;

  /// Ẩn mật khẩu
  final hidePassword = true.obs;

  /// Người dùng đã chọn "Nhớ tôi"
  final rememberMe = false.obs;

  /// Lưu trữ cục bộ để nhớ email và mật khẩu
  final localStorage = GetStorage();

  /// Bộ điều khiển chỉnh sửa văn bản cho trường email
  final email = TextEditingController();

  /// Bộ điều khiển chỉnh sửa văn bản cho trường mật khẩu
  final password = TextEditingController();

  /// Khóa mẫu cho biểu mẫu đăng nhập
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // Lấy email và mật khẩu đã lưu nếu người dùng đã chọn "Nhớ tôi"
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Xử lý quá trình đăng nhập bằng email và mật khẩu
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Bắt đầu tải
      isLoading.value = true;
      SHFFullScreenLoader.openLoadingDialog('Đang đăng nhập...', SHFImages.docerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Xác nhận biểu mẫu
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Lưu dữ liệu nếu người dùng chọn "Nhớ tôi"
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Đăng nhập người dùng bằng Email & Mật khẩu
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Lấy chi tiết người dùng và gán vào UserController
      final user = await AdminController.instance.fetchUserDetails();

      // Dừng tải
      SHFFullScreenLoader.stopLoading();

      // Nếu người dùng không phải là quản trị viên, đăng xuất và trả về
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        SHFLoaders.errorSnackBar(title: 'Không được ủy quyền', message: 'Bạn không được ủy quyền hoặc có quyền truy cập. Liên hệ với quản trị viên');
      } else {
        // Chuyển hướng
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      isLoading.value = false;
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Xử lý việc đăng ký người dùng quản trị
  Future<void> registerAdmin() async {
    try {
      // Bắt đầu tải
      isLoading.value = true;
      SHFFullScreenLoader.openLoadingDialog('Đang đăng ký tài khoản quản trị...', SHFImages.docerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Đăng ký người dùng bằng Email & Mật khẩu
      await AuthenticationRepository.instance.registerWithEmailAndPassword(SHFTexts.adminEmail, SHFTexts.adminPassword);

      // Tạo bản ghi quản trị trong Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'Bùi Thiện Chí',
          lastName: 'Admin',
          email: SHFTexts.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      // Dừng tải
      SHFFullScreenLoader.stopLoading();

      // Chuyển hướng
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      isLoading.value = false;
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
