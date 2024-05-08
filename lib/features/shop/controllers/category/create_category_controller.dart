import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/category_model.dart';
import 'category_controller.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxString imageURL = ''.obs;

  /// Method to reset fields
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }

  /// Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Register new Category
  Future<void> createCategory() async {
    try {
      // Start Loading
      SHFFullScreenLoader.popUpCircular();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = CategoryModel(
        id: '',
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        parentId: selectedParent.value.id,
      );

      // Call Repository to Create New Category
      newRecord.id =
          await CategoryRepository.instance.createCategory(newRecord);

      // Update All Data list
      CategoryController.instance.addItemToLists(newRecord);

      // Reset Form
      resetFields();

      // Remove Loader
      SHFFullScreenLoader.stopLoading();

      // Success Message & Redirect
      SHFLoaders.successSnackBar(
          title: 'Chúc mừng', message: 'Bản ghi mới đã được thêm vào.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
