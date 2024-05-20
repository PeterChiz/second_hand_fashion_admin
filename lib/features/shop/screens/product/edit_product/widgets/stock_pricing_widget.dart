import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return Obx(
      () => controller.productType.value == ProductType.single
          ? Form(
              key: controller.stockPriceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stock
                  FractionallySizedBox(
                    widthFactor: 0.45,
                    child: TextFormField(
                      controller: controller.stock,
                      decoration: const InputDecoration(labelText: 'Số lượng'),
                      validator: (value) => SHFValidator.validationEmptyText('Số lượng', value),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwInputFields),

                  // Pricing
                  Row(
                    children: [
                      // Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.price,
                          decoration: const InputDecoration(labelText: 'Giá', hintText: 'đ'),
                          validator: (value) => SHFValidator.validationEmptyText('Giá', value),
                        ),
                      ),
                      const SizedBox(width: SHFSizes.spaceBtwItems),

                      // Sale Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.salePrice,
                          decoration: const InputDecoration(labelText: 'Giá ưu đãi', hintText: 'đ'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
