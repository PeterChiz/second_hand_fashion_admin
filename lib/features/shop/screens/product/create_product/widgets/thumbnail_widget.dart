import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_images_controller.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller =
        Get.put(ProductImagesController());

    return SHFRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Văn bản cho Ảnh Đại Diện Sản Phẩm
          Text('Ảnh Đại Diện Sản Phẩm',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // Container cho Ảnh Đại Diện Sản Phẩm
          SHFRoundedContainer(
            height: 300,
            backgroundColor: SHFColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ảnh Đại Diện
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => SHFRoundedImage(
                            width: 220,
                            height: 220,
                            image: controller.selectedThumbnailImageUrl.value ??
                                SHFImages.defaultSingleImageIcon,
                            imageType:
                                controller.selectedThumbnailImageUrl.value ==
                                        null
                                    ? ImageType.asset
                                    : ImageType.network,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Nút Thêm Ảnh Đại Diện
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () => controller.selectThumbnailImage(),
                      child: const Text('Thêm Ảnh Đại Diện'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
