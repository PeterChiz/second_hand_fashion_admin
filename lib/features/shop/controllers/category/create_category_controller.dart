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

  /// Phương thức để đặt lại các trường
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }

  /// Chọn Hình ảnh Thumbnail từ Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Xử lý các hình ảnh đã chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Đặt hình ảnh được chọn là hình ảnh chính hoặc thực hiện bất kỳ hành động nào khác
      ImageModel selectedImage = selectedImages.first;
      // Cập nhật hình ảnh chính bằng selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Đăng ký Danh mục mới
  Future<void> createCategory() async {
    try {
      // Bắt đầu Loading
      SHFFullScreenLoader.popUpCircular();

      // Kiểm tra Kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Kiểm tra Validation Form
      if (!formKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Map Dữ liệu
      final newRecord = CategoryModel(
        id: '',
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        parentId: selectedParent.value.id,
      );

      // Gọi Repository để Tạo Danh mục Mới
      newRecord.id =
      await CategoryRepository.instance.createCategory(newRecord);

      // Cập nhật Tất cả dữ liệu danh sách
      CategoryController.instance.addItemToLists(newRecord);

      // Đặt lại Form
      resetFields();

      // Xóa Loader
      SHFFullScreenLoader.stopLoading();

      // Thông báo thành công & Chuyển hướng
      SHFLoaders.successSnackBar(
          title: 'Chúc mừng', message: 'Bản ghi mới đã được thêm vào.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
