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

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(CategoryRepository());

  /// Khởi tạo dữ liệu
  void init(CategoryModel category){
    if(category.parentId.isNotEmpty) {
      selectedParent.value = CategoryController.instance.allItems.where((c) => c.id == category.parentId).single;
    }
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
  }

  /// Phương thức để đặt lại các trường
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }

  /// Chọn ảnh thu nhỏ từ phương tiện
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Xử lý các ảnh được chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Đặt ảnh được chọn là ảnh chính hoặc thực hiện bất kỳ hành động nào khác
      ImageModel selectedImage = selectedImages.first;
      // Cập nhật ảnh chính bằng cách sử dụng selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Đăng ký danh mục mới
  Future<void> updateCategory(CategoryModel category) async {
    try {
      // Bắt đầu tải
      SHFFullScreenLoader.popUpCircular();

      // Kiểm tra Kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Xác nhận Form
      if (!formKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Ánh xạ Dữ liệu
      category.image = imageURL.value;
      category.name = name.text.trim();
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();

      // Gọi Repository để Cập nhật Danh mục
      await repository.updateCategory(category);

      // Cập nhật Tất cả danh sách Dữ liệu
      CategoryController.instance.updateItemFromLists(category);

      // Đặt lại Form
      resetFields();

      // Loại bỏ Loader
      SHFFullScreenLoader.stopLoading();

      // Thông báo Thành công & Chuyển hướng
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Bản ghi của bạn đã được cập nhật.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
