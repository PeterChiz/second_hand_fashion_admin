import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/brands/brand_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/brand_category_model.dart';
import '../../models/brand_model.dart';
import '../../models/category_model.dart';
import 'brand_controller.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Chuyển đổi Lựa chọn Danh mục
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }

    update();
  }

  /// Phương thức để đặt lại các trường
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
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

  /// Đăng ký thương hiệu mới
  Future<void> createBrand() async {
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
      final newRecord = BrandModel(
        id: '',
        productsCount: 0,
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      // Gọi Repository để Tạo Thương hiệu Mới
      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      // Đăng ký các danh mục thương hiệu nếu có
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Lỗi lưu trữ dữ liệu quan hệ. Thử lại';

        // Lặp lại các Danh mục Thương hiệu được chọn
        for (var category in selectedCategories) {
          // Map Dữ liệu
          final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id);
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Cập nhật Tất cả dữ liệu danh sách
      BrandController.instance.addItemToLists(newRecord);

      // Cập nhật Listeners UI
      update();

      // Đặt lại Form
      resetFields();

      // Xóa Loader
      SHFFullScreenLoader.stopLoading();

      // Thông báo thành công & Chuyển hướng
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Bản ghi mới đã được thêm vào.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
