import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../../../../controllers/product/product_variations_controller.dart';
import '../../../../models/product_variation_model.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;

    return Obx(
      () => EditProductController.instance.productType.value ==
              ProductType.variable
          ? SHFRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header cho Biến thể Sản phẩm
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Biến thể Sản phẩm',
                          style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                        onPressed: () =>
                            variationController.removeVariations(context),
                        child: const Text('Xóa Biến thể'),
                      ),
                    ],
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),

                  // Danh sách Biến thể
                  if (variationController.productVariations.isNotEmpty)
                    ListView.separated(
                      itemCount: variationController.productVariations.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: SHFSizes.spaceBtwItems),
                      itemBuilder: (_, index) {
                        final variation =
                            variationController.productVariations[index];
                        return _buildVariationTile(
                            context, index, variation, variationController);
                      },
                    )
                  else
                    _buildNoVariationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // Phương thức hỗ trợ để tạo tile cho biến thể
  Widget _buildVariationTile(
      BuildContext context,
      int index,
      ProductVariationModel variation,
      ProductVariationController variationController) {
    return ExpansionTile(
      backgroundColor: SHFColors.lightGrey,
      collapsedBackgroundColor: SHFColors.lightGrey,
      childrenPadding: const EdgeInsets.all(SHFSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SHFSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(', ')),
      children: [
        // Tải ảnh Biến thể
        Obx(
          () => SHFImageUploader(
            right: 0,
            left: null,
            circular: true,
            imageType: variation.image.value.isNotEmpty
                ? ImageType.network
                : ImageType.asset,
            image: variation.image.value.isNotEmpty
                ? variation.image.value
                : SHFImages.defaultImage,
            onIconButtonPressed: () => ProductImagesController.instance
                .selectVariationImage(variation),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwInputFields),

        // Kho Biến thể và Giá
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => variation.stock = int.parse(value),
                decoration:
                    const InputDecoration(labelText: 'Kho', hintText: '0'),
                controller: variationController.stockControllersList[index]
                    [variation],
              ),
            ),
            const SizedBox(width: SHFSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => variation.price = double.parse(value),
                decoration:
                    const InputDecoration(labelText: 'Giá', hintText: 'đ'),
                controller: variationController.priceControllersList[index]
                    [variation],
              ),
            ),
            const SizedBox(width: SHFSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => variation.salePrice = double.parse(value),
                controller: variationController.salePriceControllersList[index]
                    [variation],
                decoration: const InputDecoration(
                    labelText: 'Giá ưu đãi', hintText: 'đ'),
              ),
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwInputFields),

        // Mô tả Biến thể
        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationController.descriptionControllersList[index]
              [variation],
          decoration: const InputDecoration(
              labelText: 'Mô tả', hintText: 'Thêm mô tả của biến thể này...'),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),
      ],
    );
  }

  // Phương thức hỗ trợ để hiển thị thông báo khi không có biến thể
  Widget _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SHFRoundedImage(
                width: 200,
                height: 200,
                imageType: ImageType.asset,
                image: SHFImages.defaultVariationImageIcon),
          ],
        ),
        SizedBox(height: SHFSizes.spaceBtwItems),
        Text('Không có Biến thể nào được thêm cho sản phẩm này'),
      ],
    );
  }
}
