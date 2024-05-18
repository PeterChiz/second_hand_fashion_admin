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
import '../../../../controllers/product/edit_product_controller.dart';
import '../../../../controllers/product/product_attributes_controller.dart';
import '../../../../controllers/product/product_variations_controller.dart';

class ProductAttributes extends StatelessWidget {
  ProductAttributes({
    super.key,
  });

  // Các bộ điều khiển
  final attributeController = Get.put(ProductAttributesController());
  final variationController = Get.put(ProductVariationController());

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Phân cách dựa trên loại sản phẩm
        Obx(() => productController.productType.value == ProductType.single
            ? const Divider(color: SHFColors.primaryBackground)
            : const SizedBox.shrink()),
        Obx(() => productController.productType.value == ProductType.single
            ? const SizedBox(height: SHFSizes.spaceBtwSections)
            : const SizedBox.shrink()),

        Text('Thêm Thuộc Tính Sản Phẩm', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: SHFSizes.spaceBtwItems),

        // Biểu mẫu để thêm thuộc tính mới
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

        // Danh sách các thuộc tính đã thêm
        Text('Tất Cả Thuộc Tính', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: SHFSizes.spaceBtwItems),

        // Hiển thị các thuộc tính đã thêm trong một hộp tròn
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
                Text('Không có thuộc tính nào được thêm cho sản phẩm này'),
              ],
            ),
          ),
        ),

        const SizedBox(height: SHFSizes.spaceBtwSections),

        // Nút Tạo Biến Thể
        Obx(
              () => productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty
              ? Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                icon: const Icon(Iconsax.activity),
                label: const Text('Tạo Biến Thể'),
                onPressed: () => variationController.generateVariationsConfirmation(context),
              ),
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  // Xây dựng nút để thêm thuộc tính mới
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
        label: const Text('Thêm'),
      ),
    );
  }

  // Xây dựng trường văn bản cho tên thuộc tính
  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) => SHFValidator.validationEmptyText('Tên Thuộc Tính', value),
      decoration: const InputDecoration(labelText: 'Tên Thuộc Tính', hintText: 'Màu sắc, Kích thước, Chất liệu'),
    );
  }

  // Xây dựng trường văn bản cho các giá trị thuộc tính
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
        validator: (value) => SHFValidator.validationEmptyText('Trường Thuộc Tính', value),
        decoration: const InputDecoration(
          labelText: 'Thuộc Tính',
          hintText: 'Thêm thuộc tính cách nhau bởi |  Ví dụ: Xanh lá | Xanh dương | Vàng',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
