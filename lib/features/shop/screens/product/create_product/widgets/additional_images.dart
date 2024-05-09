import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({super.key, required this.additionalProductImagesURLs, this.onTapToAddImages, this.onTapToRemoveImage});

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SizedBox(
        height: 300,
        child: Column(
          children: [
            // Phần thêm hình ảnh sản phẩm bổ sung
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTapToAddImages,
                child: SHFRoundedContainer(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(SHFImages.defaultMultiImageIcon, width: 50, height: 50),
                        const Text('Thêm hình ảnh sản phẩm bổ sung'),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Phần hiển thị hình ảnh đã tải lên
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 2, child: SizedBox(height: 80, child: _uploadedImagesOrEmptyList())),
                  const SizedBox(width: SHFSizes.spaceBtwItems / 2),

                  // Nút Thêm Hình Ảnh
                  SHFRoundedContainer(
                    width: 80,
                    height: 80,
                    showBorder: true,
                    borderColor: SHFColors.grey,
                    backgroundColor: SHFColors.white,
                    onTap: onTapToAddImages,
                    child: const Center(child: Icon(Iconsax.add)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị hình ảnh đã tải lên hoặc danh sách trống
  Widget _uploadedImagesOrEmptyList() {
    return additionalProductImagesURLs.isNotEmpty ? _uploadedImages() : emptyList();
  }

  // Widget hiển thị danh sách trống
  Widget emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: SHFSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) => const SHFRoundedContainer(backgroundColor: SHFColors.primaryBackground, width: 80, height: 80),
    );
  }

  // Widget hiển thị hình ảnh đã tải lên
  ListView _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesURLs.length,
      separatorBuilder: (context, index) => const SizedBox(width: SHFSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
        return SHFImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          image: image,
          icon: Iconsax.trash,
          imageType: ImageType.network,
          onIconButtonPressed: () => onTapToRemoveImage!(index),
        );
      },
    );
  }
}
