import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banners_repository.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/banner_model.dart';
import 'banner_controller.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();

  /// Chọn Hình Ảnh Đại Diện từ Phương Tiện
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Xử lý các hình ảnh đã chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Đặt hình ảnh đã chọn là hình ảnh chính hoặc thực hiện bất kỳ hành động nào khác
      ImageModel selectedImage = selectedImages.first;
      // Cập nhật hình ảnh chính bằng selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Đăng ký Banner mới
  Future<void> createBanner() async {
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

      // Ánh xạ Dữ liệu
      final newRecord = BannerModel(
        id: '',
        active: isActive.value,
        imageUrl: imageURL.value,
        targetScreen: targetScreen.value,
      );

      // Gọi Repository để Tạo Banner mới và cập nhật Id
      newRecord.id = await BannerRepository.instance.createBanner(newRecord);

      // Cập nhật Tất cả danh sách dữ liệu
      BannerController.instance.addItemToLists(newRecord);

      // Loại bỏ Loader
      SHFFullScreenLoader.stopLoading();

      // Thông báo Thành công & Chuyển hướng
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Bản ghi mới đã được thêm vào.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
