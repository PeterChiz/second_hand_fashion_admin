import 'package:get/get.dart';

import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/product_variation_model.dart';

class ProducSHFImagesController extends GetxController {
  // Singleton instance
  static ProducSHFImagesController get instance => Get.find();

  // Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // Lists to store additional product images
  final RxList<String> additionalProducSHFImagesUrls = <String>[].obs;

  /// Function to remove Product image
  Future<void> removeImage(int index) async {
    additionalProducSHFImagesUrls.removeAt(index);
  }

  /// Pick Thumbnail Image from Media
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selecSHFImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  /// Pick Thumbnail Image from Media
  void selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selecSHFImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      variation.image.value = selectedImage.url;
    }
  }

  /// Pick Thumbnail Image from Gallery
  void selectMultipleProducSHFImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await controller.selecSHFImagesFromMedia(allowMultipleSelection: true, alreadySelectedUrls: additionalProducSHFImagesUrls);

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProducSHFImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }
}
