import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/media_controller.dart';
import '../../../models/image_model.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Obx(
          () => controller.showImagesUploaderSection.value
          ? Column(
        children: [
          SHFRoundedContainer(
            height: 250,
            showBorder: true,
            borderColor: SHFColors.borderPrimary,
            backgroundColor: SHFColors.primaryBackground,
            padding: const EdgeInsets.all(SHFSizes.defaultSpace),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DropzoneView(
                        mime: const ['image/jpeg', 'image/png', 'image/jpg'],
                        cursor: CursorType.Default,
                        operation: DragOperation.copy,
                        onCreated: (ctrl) =>
                        controller.dropzoneController = ctrl,
                        onLoaded: () => print('Zone đã tải'),
                        onError: (ev) => print('Lỗi Zone: $ev'),
                        onHover: () {
                          print('Zone đã rê chuột vào');
                        },
                        onLeave: () {
                          print('Zone đã rời đi');
                        },
                        onDrop: (ev) async {
                          if (ev is html.File) {
                            final bytes = await controller
                                .dropzoneController
                                .getFileData(ev);
                            final image = ImageModel(
                              url: '',
                              file: ev,
                              folder: '',
                              filename: ev.name,
                              localImageToDisplay:
                              Uint8List.fromList(bytes),
                            );
                            controller.selectedImagesToUpload.add(image);
                          } else if (ev is String) {
                            print('Zone đã thả: $ev');
                          } else {
                            print('Kiểu Zone không xác định: ${ev.runtimeType}');
                          }
                        },
                        onDropInvalid: (ev) =>
                            print('Zone không hợp lệ MIME: $ev'),
                        onDropMultiple: (ev) async {
                          print('Zone thả nhiều: $ev');
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(SHFImages.defaultMultiImageIcon,
                              width: 50, height: 50),
                          const SizedBox(height: SHFSizes.spaceBtwItems),
                          const Text('Kéo và Thả Hình Ảnh vào Đây'),
                          const SizedBox(height: SHFSizes.spaceBtwItems),
                          OutlinedButton(
                              onPressed: () =>
                                  controller.selectLocalImages(),
                              child: const Text('Chọn Hình Ảnh')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // Hiển thị hình ảnh đã chọn cục bộ
          if (controller.selectedImagesToUpload.isNotEmpty)
            SHFRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Chọn Thư Mục',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall),
                          const SizedBox(width: SHFSizes.spaceBtwItems),
                          Obx(
                                () => SizedBox(
                              width: 200,
                              child:
                              DropdownButtonFormField<MediaCategory>(
                                isExpanded: false,
                                value: controller.selectedPath.value,
                                onChanged: (MediaCategory? newValue) {
                                  if (newValue != null) {
                                    controller.selectedPath.value =
                                        newValue;
                                    controller.getBannerImages();
                                  }
                                },
                                items:
                                MediaCategory.values.map((category) {
                                  return DropdownMenuItem<MediaCategory>(
                                    value: category,
                                    child: Text(category.name.capitalize
                                        .toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () => controller
                                  .selectedImagesToUpload
                                  .clear(),
                              child: const Text('Xóa Tất Cả')),
                          const SizedBox(width: SHFSizes.spaceBtwItems),
                          SizedBox(
                            width: SHFSizes.buttonWidth,
                            child: ElevatedButton(
                              onPressed: () => controller
                                  .uploadImagesConfirmation(),
                              child: const Text('Tải Lên'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: SHFSizes.spaceBtwItems / 2,
                    runSpacing: SHFSizes.spaceBtwItems / 2,
                    children: controller.selectedImagesToUpload
                        .where(
                            (image) => image.localImageToDisplay != null)
                        .map((element) => SHFRoundedImage(
                      width: 90,
                      height: 90,
                      padding: SHFSizes.sm,
                      imageType: ImageType.memory,
                      memoryImage: element.localImageToDisplay,
                      backgroundColor:
                      SHFColors.primaryBackground,
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          controller.uploadImagesConfirmation(),
                      child: const Text('Tải Lên'),
                    ),
                  )
                ],
              ),
            ),
          const SizedBox(height: SHFSizes.spaceBtwSections),
        ],
      )
          : const SizedBox.shrink(),
    );
  }
}
