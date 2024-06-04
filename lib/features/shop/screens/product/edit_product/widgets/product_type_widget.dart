import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return Obx(
          () => Row(
        children: [
          Text('Loại sản phẩm', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: SHFSizes.spaceBtwItems),
          // Nút radio cho Loại sản phẩm Đơn
          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) {
              // Cập nhật loại sản phẩm đã chọn trong controller
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Đơn'),
          ),
          // Nút radio cho Loại sản phẩm Biến thể
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) {
              // Cập nhật loại sản phẩm đã chọn trong controller
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Biến thể'),
          ),
        ],
      ),
    );
  }
}
