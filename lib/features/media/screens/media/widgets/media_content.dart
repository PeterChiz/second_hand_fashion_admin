import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/media_controller.dart';
import '../../../models/image_model.dart';
import 'view_image_details.dart';

class MediaContent extends StatelessWidget {
  MediaContent({
    super.key,
    this.allowSelection = false,
    this.allowMultipleSelection = false,
    this.onImagesSelected,
    this.alreadySelectedUrls,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = Get.put(MediaController());
    return SHFRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Gallery Folders', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(width: SHFSizes.spaceBtwItems),

                  // Media Dropdown
                  _buildMediaDropdown(controller),
                ],
              ),

              // Add Selected Images Button
              if (allowSelection) buildAddSelectedImagesButton(),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Show Media
          Obx(() {
            // Get Selected Folder Images
            List<ImageModel> images = _getSelectedFolderImages(controller);

            // Check already selected Images
            final totalImages = controller.selectedCloudImagesCount.value;

            // Load Selected Images from the Already Selected Images only once otherwise
            // rebuild of UI will keep the images selected until all images loaded
            if (!loadedPreviousSelection) {
              if (alreadySelectedUrls != null && alreadySelectedUrls!.isNotEmpty) {
                for (var image in images) {
                  if (alreadySelectedUrls!.contains(image.url)) {
                    image.isSelected.value = true;
                    selectedImages.add(image);
                  } else {
                    image.isSelected.value = false;
                  }
                }
                loadedPreviousSelection = true;
              }
            }

            // Loader
            if (controller.loading.value && images.isEmpty) return const SHFLoaderAnimation();

            // Empty Widget
            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: images
                      .map((image) => GestureDetector(
                            onTap: () => Get.dialog(ImagePopup(image: image)),
                            child: SizedBox(
                              width: 140,
                              height: 180,
                              child: Column(
                                children: [
                                  allowSelection ? _buildListWithCheckbox(image) : _buildSimpleList(image),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: SHFSizes.sm),
                                      child: Text(image.filename, maxLines: 1, overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),

                // Load More Button -> Show when all images loaded
                if (totalImages != images.length && !controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: SHFSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SHFSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreBannerImages(),
                            label: const Text('Load More'),
                            icon: const Icon(Iconsax.arrow_down),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Padding _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SHFSizes.lg * 3),
      child: SHFAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: SHFImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProducSHFImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages.where((image) => image.url.isNotEmpty).toList();
    }
    return images;
  }

  SizedBox buildAddSelectedImagesButton() {
    return SizedBox(
      width: 120,
      child: ElevatedButton.icon(
        label: const Text('Add'),
        icon: const Icon(Iconsax.image),
        onPressed: () {
          if (alreadySelectedUrls != null) alreadySelectedUrls!.clear();

          // Create a copy of the selected images to send back
          List<ImageModel> selectedImagesCopy = List.from(selectedImages);

          // Before calling Get.back, clear the selectedImages
          for (var otherImage in selectedImages) {
            otherImage.isSelected.value = false;
          }
          selectedImages.clear();

          // Now call Get.back with the result
          Get.back(result: selectedImagesCopy);
        },
      ),
    );
  }

  Obx _buildMediaDropdown(MediaController controller) {
    return Obx(
      () => SizedBox(
        width: 140,
        child: DropdownButtonFormField<MediaCategory>(
          isExpanded: false,
          value: controller.selectedPath.value,
          onChanged: (MediaCategory? newValue) {
            if (newValue != null) {
              for (var otherImage in selectedImages) {
                otherImage.isSelected.value = false;
              }
              selectedImages.clear();

              controller.selectedPath.value = newValue;
              controller.getBannerImages();
            }
          },
          items: MediaCategory.values.map((category) {
            return DropdownMenuItem<MediaCategory>(
              value: category,
              child: Text(category.name.capitalize.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return SHFRoundedImage(
      width: 140,
      height: 140,
      padding: SHFSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: SHFSizes.spaceBtwItems / 2,
      backgroundColor: SHFColors.primaryBackground,
    );
  }

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        SHFRoundedImage(
          width: 140,
          height: 140,
          padding: SHFSizes.sm,
          image: image.url,
          imageType: ImageType.network,
          margin: SHFSizes.spaceBtwItems / 2,
          backgroundColor: SHFColors.primaryBackground,
        ),
        Positioned(
          top: SHFSizes.md,
          right: SHFSizes.md,
          child: Obx(
            () => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                // If selection is allowed, toggle the selected state
                if (selected != null) {
                  image.isSelected.value = selected;
                  if (image.isSelected.value) {
                    if (!allowMultipleSelection) {
                      // If multiple selection is not allowed, uncheck other checkboxes
                      for (var otherImage in selectedImages) {
                        if (otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }

                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}