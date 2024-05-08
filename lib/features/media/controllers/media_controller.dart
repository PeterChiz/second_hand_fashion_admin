import 'dart:html' as html;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../data/repositories/media/media_repository.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/popups/dialogs.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/image_model.dart';
import '../screens/media/widgets/media_content.dart';

/// Controller for managing media operations
class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneController;

  // Lists to store additional product images
  final RxBool loading = false.obs;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late ListResult bannerImagesListResult;
  late ListResult productImagesListResult;
  late ListResult brandImagesListResult;
  late ListResult categoryImagesListResult;
  late ListResult userImagesListResult;

  final RxInt selectedCloudImagesCount = 0.obs;
  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;
  final MediaRepository mediaRepository = MediaRepository();

  // Get Images
  void getBannerImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners && allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands && allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories && allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products && allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users && allUserImages.isEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(selectedPath.value, initialLoadCount);
      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: 'Không thể tìm nạp Hình ảnh, Đã xảy ra lỗi. Thử lại');
    }
  }

  Future<void> selectLocalImages() async {
    final files = await dropzoneController.pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);

    if (files.isNotEmpty) {
      for (var file in files) {
        if (file is html.File) {
          final bytes = await dropzoneController.getFileData(file);
          final image = ImageModel(
            url: '',
            file: file,
            folder: '',
            filename: file.name,
            localImageToDisplay: Uint8List.fromList(bytes),
          );
          selectedImagesToUpload.add(image);
        }
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      SHFLoaders.warningSnackBar(title: 'Chọn thư mục', message: 'Vui lòng chọn Thư mục theo Thứ tự để tải Hình ảnh lên.');
      return;
    }

    SHFDialogs.defaultDialog(
      context: Get.context!,
      title: 'Đăng tải hình ảnh',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content: 'Bạn có chắc chắn muốn tải lên tất cả các Hình ảnh trong thư mục ${selectedPath.value.name.toUpperCase()} ?',
    );
  }

  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();

      // Start Loader
      uploadImagesLoader();

      // Get the selected category
      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Upload and add images to the target list
      // Using a reverse loop to avoid 'Concurrent modification during iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file!;

        // Upload Image to the Storage
        final ImageModel uploadedImage = await mediaRepository.uploadImageFileInStorage(
          file: image,
          path: getSelectedPath(),
          imageName: selectedImage.filename,
        );

        // Upload Image to the Firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id = await mediaRepository.uploadImageFileInDatabase(uploadedImage);

        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }

      // Stop Loader after successful upload
      SHFFullScreenLoader.stopLoading();
    } catch (e) {
      // Stop Loader in case of an error
      SHFFullScreenLoader.stopLoading();
      // Show a warning snackbar for the error
      SHFLoaders.warningSnackBar(title: 'Lỗi tải hình ảnh lên', message: 'Đã xảy ra lỗi khi tải hình ảnh của bạn lên.');
    }
  }

  loadMoreBannerImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value, initialLoadCount, targetList.last.createdAt ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: 'Không thể tìm nạp Hình ảnh, Đã xảy ra lỗi. Thử lại');
    }
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = SHFTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = SHFTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = SHFTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = SHFTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = SHFTexts.usersStoragePath;
        break;
      default:
        path = 'Chọn cái khác';
    }

    return path;
  }

  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Tải hình ảnh lên'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(SHFImages.uploadingImageIllustration, height: 300, width: 300),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              const Text('Hình ảnh của bạn đang được tải lên...'),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to remove cloud image
  void removeCloudImageConfirmation(ImageModel image) {
    // Delete Confirmation
    SHFDialogs.defaultDialog(
      context: Get.context!,
      content: 'Bạn có chắc muốn xóa ảnh này không?',
      onConfirm: () {
        // Close the previous Dialog
        Get.back();

        removeCloudImage(image);
      },
    );
  }

  removeCloudImage(ImageModel image) async {
    try {
      // Close the previous Dialog
      Get.back();

      // Show Loader
      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const PopScope(canPop: false, child: SizedBox(width: 150, height: 150, child: SHFCircularLoader())),
      );

      // Delete Image
      await mediaRepository.deleteFileFromStorage(image, getSelectedPath());

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Remove from the list
      targetList.remove(image);

      update();
      SHFFullScreenLoader.stopLoading();

      SHFLoaders.successSnackBar(title: 'Đã xóa hình ảnh', message: 'Hình ảnh đã được xóa thành công khỏi cloud storage của bạn');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImagesFromMedia(
      {List<String>? alreadySelectedUrls, bool allowSelection = true, bool allowMultipleSelection = false}) async {
    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      SingleChildScrollView(
        child: MediaContent(
          allowSelection: allowSelection,
          alreadySelectedUrls: alreadySelectedUrls ?? [],
          allowMultipleSelection: allowMultipleSelection,
        ),
      ),
    );

    return selectedImages;
  }

  void clearSelection() {
    selectedPath.value = MediaCategory.banners;
    selectedImagesToUpload.clear();
  }
}
