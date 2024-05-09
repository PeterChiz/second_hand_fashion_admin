import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
      () => Row(
        children: [
          Text('Loại Sản Phẩm', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: SHFSizes.spaceBtwItems),
          // Nút Radio cho Loại Sản Phẩm Đơn
          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) {
              // Cập nhật loại sản phẩm được chọn trong controller
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Đơn'),
          ),
          // Nút Radio cho Loại Sản Phẩm Biến Thể
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) {
              // Cập nhật loại sản phẩm được chọn trong controller
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Biến Thể'),
          ),
        ],
      ),
    );
  }
}
