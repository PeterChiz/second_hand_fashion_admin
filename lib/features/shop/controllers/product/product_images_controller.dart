import 'package:get/get.dart';

import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/product_variation_model.dart';

class ProductImagesController extends GetxController {
  // Thể hiện duy nhất
  static ProductImagesController get instance => Get.find();

  // Rx Observables cho ảnh xem trước được chọn
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // Danh sách để lưu trữ các hình ảnh sản phẩm bổ sung
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Hàm để xóa hình ảnh Sản phẩm
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }

  /// Chọn ảnh xem trước từ Phương tiện
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Xử lý các ảnh được chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Đặt ảnh được chọn là ảnh chính hoặc thực hiện bất kỳ hành động nào khác
      ImageModel selectedImage = selectedImages.first;
      // Cập nhật ảnh chính bằng cách sử dụng selectedImage
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  /// Chọn ảnh xem trước từ Phương tiện
  void selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Xử lý các ảnh được chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Đặt ảnh được chọn là ảnh chính hoặc thực hiện bất kỳ hành động nào khác
      ImageModel selectedImage = selectedImages.first;
      // Cập nhật ảnh chính bằng cách sử dụng selectedImage
      variation.image.value = selectedImage.url;
    }
  }

  /// Chọn ảnh xem trước từ Thư viện ảnh
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages =
    await controller.selectImagesFromMedia(allowMultipleSelection: true, alreadySelectedUrls: additionalProductImagesUrls);

    // Xử lý các ảnh được chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }
}
