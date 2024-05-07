
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/create_product_controller.dart';
import '../../../../controllers/product/product_attributes_controller.dart';
import '../../../../controllers/product/product_variations_controller.dart';

class ProductAttributes extends StatelessWidget {
  ProductAttributes({
    super.key,
  });

  // Controllers
  final attributeController = Get.put(ProductAttributesController());
  final variationController = Get.put(ProductVariationController());

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider based on product type
        Obx(() => productController.productType.value == ProductType.single
            ? const Divider(color: SHFColors.primaryBackground)
            : const SizedBox.shrink()),
        Obx(() => productController.productType.value == ProductType.single
            ? const SizedBox(height: SHFSizes.spaceBtwSections)
            : const SizedBox.shrink()),

        Text('Add Product Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: SHFSizes.spaceBtwItems),

        // Form to add new attribute
        Form(
          key: attributeController.attributesFormKey,
          child: SHFDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildAttributeName(attributeController),
                    ),
                    const SizedBox(width: SHFSizes.spaceBtwItems),
                    Expanded(
                      flex: 2,
                      child: _buildAttributes(attributeController),
                    ),
                    const SizedBox(width: SHFSizes.spaceBtwItems),
                    _buildAddAttributeButton(attributeController),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(attributeController),
                    const SizedBox(height: SHFSizes.spaceBtwItems),
                    _buildAttributes(attributeController),
                    const SizedBox(height: SHFSizes.spaceBtwItems),
                    _buildAddAttributeButton(attributeController),
                  ],
                ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        // List of added attributes
        Text('All Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: SHFSizes.spaceBtwItems),

        // Display added attributes in a rounded container
        SHFRoundedContainer(
          backgroundColor: SHFColors.primaryBackground,
          child: Obx(
            () => attributeController.productAttributes.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: attributeController.productAttributes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: SHFSizes.spaceBtwItems),
                    itemBuilder: (_, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: SHFColors.white,
                          borderRadius: BorderRadius.circular(SHFSizes.borderRadiusLg),
                        ),
                        child: ListTile(
                          title: Text(attributeController.productAttributes[index].name ?? ''),
                          subtitle: Text(attributeController.productAttributes[index].values!.map((e) => e.trim()).toString()),
                          trailing: IconButton(
                            onPressed: () => attributeController.removeAttribute(index, context),
                            icon: const Icon(Iconsax.trash, color: SHFColors.error),
                          ),
                        ),
                      );
                    },
                  )
                : const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SHFRoundedImage(width: 150, height: 80, imageType: ImageType.asset, image: SHFImages.defaultAttributeColorsImageIcon),
                        ],
                      ),
                      SizedBox(height: SHFSizes.spaceBtwItems),
                      Text('There are no attributes added for this product'),
                    ],
                  ),
          ),
        ),

        const SizedBox(height: SHFSizes.spaceBtwSections),

        // Generate Variations Button
        Obx(
          () => productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty
              ? Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      icon: const Icon(Iconsax.activity),
                      label: const Text('Generate Variations'),
                      onPressed: () => variationController.generateVariationsConfirmation(context),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  // Build button to add a new attribute
  SizedBox _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: SHFColors.black,
          backgroundColor: SHFColors.secondary,
          side: const BorderSide(color: SHFColors.secondary),
        ),
        label: const Text('Add'),
      ),
    );
  }

  // Build text form field for attribute name
  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) => SHFValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(labelText: 'Attribute Name', hintText: 'Colors, Sizes, Material'),
    );
  }

  // Build text form field for attribute values
  SizedBox _buildAttributes(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: controller.attributes,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) => SHFValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText: 'Add attributes separated by |  Example: Green | Blue | Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
