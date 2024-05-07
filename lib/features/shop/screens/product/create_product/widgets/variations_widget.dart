
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';
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
      () => CreateProductController.instance.productType.value == ProductType.variable
          ? SHFRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Variations Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Variations', style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                        onPressed: () => variationController.removeVariations(context),
                        child: const Text('Remove Variations'),
                      ),
                    ],
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),

                  // Variations List
                  if (variationController.productVariations.isNotEmpty)
                    ListView.separated(
                      itemCount: variationController.productVariations.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(height: SHFSizes.spaceBtwItems),
                      itemBuilder: (_, index) {
                        final variation = variationController.productVariations[index];
                        return _buildVariationTile(context, index, variation, variationController);
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

  // Helper method to build a variation tile
  Widget _buildVariationTile(
      BuildContext context, int index, ProductVariationModel variation, ProductVariationController variationController) {
    return ExpansionTile(
      backgroundColor: SHFColors.lightGrey,
      collapsedBackgroundColor: SHFColors.lightGrey,
      childrenPadding: const EdgeInsets.all(SHFSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ')),
      children: [
        // Upload Variation Image
        Obx(
          () => SHFImageUploader(
            right: 0,
            left: null,
            imageType: variation.image.value.isNotEmpty ? ImageType.network : ImageType.asset,
            image: variation.image.value.isNotEmpty ? variation.image.value : SHFImages.defaultImage,
            onIconButtonPressed: () => ProducSHFImagesController.instance.selectVariationImage(variation),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwInputFields),

        // Variation Stock, and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                decoration: const InputDecoration(labelText: 'Stock', hintText: 'Add Stock, only numbers are allowed'),
                controller: variationController.stockControllersList[index][variation],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: SHFSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                onChanged: (value) => variation.price = double.parse(value),
                decoration: const InputDecoration(labelText: 'Price', hintText: 'Price with up-to 2 decimals'),
                controller: variationController.priceControllersList[index][variation],
              ),
            ),
            const SizedBox(width: SHFSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                onChanged: (value) => variation.salePrice = double.parse(value),
                controller: variationController.salePriceControllersList[index][variation],
                decoration: const InputDecoration(labelText: 'Discounted Price', hintText: 'Price with up-to 2 decimals'),
              ),
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwInputFields),

        // Variation Description
        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationController.descriptionControllersList[index][variation],
          decoration: const InputDecoration(labelText: 'Description', hintText: 'Add description of this variation...'),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),
      ],
    );
  }

  // Helper method to build message when there are no variations
  Widget _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SHFRoundedImage(width: 200, height: 200, imageType: ImageType.asset, image: SHFImages.defaultVariationImageIcon),
          ],
        ),
        SizedBox(height: SHFSizes.spaceBtwItems),
        Text('There are no Variations added for this product'),
      ],
    );
  }
}
