import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banners_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/banner_model.dart';
import 'banner_controller.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final targetScreen = ''.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  /// Khởi tạo Dữ liệu
  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
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

  /// Cập nhật Banner mới
  Future<void> updateBanner(BannerModel banner) async {
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

      // Có dữ liệu được cập nhật không
      if (banner.imageUrl != imageURL.value || banner.targetScreen != targetScreen.value || banner.active != isActive.value) {

        // Map Dữ liệu
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        // Gọi Repository để Cập nhật
        await repository.updateBanner(banner);
      }

      // Cập nhật Danh sách
      BannerController.instance.updateItemFromLists(banner);

      // Cập nhật Listeners UI
      update();

      // Xóa Loader
      SHFFullScreenLoader.stopLoading();

      // Thông báo thành công & Chuyển hướng
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Bản ghi của bạn đã được cập nhật.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
