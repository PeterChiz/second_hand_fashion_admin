import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/models/user_model.dart';

/// Controller for managing admin-related data and operations
class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  // Observable variables
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  RxString selectedImage = ''.obs;
  Rx<html.File?> browserImage = Rx<html.File?>(null);
  Rx<Uint8List?> selectedRInt8ListImage = Rx<Uint8List?>(null);

  // Dependencies
  final userRepository = Get.put(UserRepository());

  // Form key and text editing controllers
  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final lastName = TextEditingController();

  @override
  void onInit() {
    // Fetch user details on controller initialization
    fetchUserDetails();
    super.onInit();
  }

  /// Fetches user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;

      return user;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  /// Gets user details
  Future<UserModel> getUserDetails() async {
    try {
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      return user;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  /// Initializes text fields with user data
  void initFields(UserModel userModel) {
    selectedImage.value = userModel.profilePicture;
    firstName.text = userModel.firstName;
    lastName.text = userModel.lastName;
    email.text = userModel.email;
    phoneNumber.text = userModel.phoneNumber;
  }

  /// Allows the user to pick an image
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
