import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/models/user_model.dart';

/// Bộ điều khiển để quản lý dữ liệu và hoạt động liên quan đến quản trị viên
class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  // Các biến quan sát
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  // Các phụ thuộc
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    // Lấy chi tiết người dùng khi bộ điều khiển được khởi tạo
    fetchUserDetails();
    super.onInit();
  }

  /// Lấy chi tiết người dùng từ kho dữ liệu
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;

      return user;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Đã xảy ra lỗi.', message: e.toString());
      return UserModel.empty();
    }
  }

}
