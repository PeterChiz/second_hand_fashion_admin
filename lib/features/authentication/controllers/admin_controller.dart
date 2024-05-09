import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
  RxString selectedImage = ''.obs;
  Rx<html.File?> browserImage = Rx<html.File?>(null);
  Rx<Uint8List?> selectedRInt8ListImage = Rx<Uint8List?>(null);

  // Các phụ thuộc
  final userRepository = Get.put(UserRepository());

  // Khóa mẫu và các bộ điều khiển chỉnh sửa văn bản
  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final lastName = TextEditingController();

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

  /// Lấy chi tiết người dùng
  Future<UserModel> getUserDetails() async {
    try {
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      return user;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Đã xảy ra lỗi.', message: e.toString());
      return UserModel.empty();
    }
  }

  /// Khởi tạo các trường văn bản với dữ liệu người dùng
  void initFields(UserModel userModel) {
    selectedImage.value = userModel.profilePicture;
    firstName.text = userModel.firstName;
    lastName.text = userModel.lastName;
    email.text = userModel.email;
    phoneNumber.text = userModel.phoneNumber;
  }

  /// Cho phép người dùng chọn một hình ảnh
  Future<void> pickImage() async {
    final imageInput = html.FileUploadInputElement()..accept = 'image/*';
    imageInput.click();

    imageInput.onChange.listen((event) {
      final file = imageInput.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((event) {
        browserImage.value = file;
        selectedRInt8ListImage.value = Uint8List.fromList(reader.result as List<int>);
      });
    });
  }
}
