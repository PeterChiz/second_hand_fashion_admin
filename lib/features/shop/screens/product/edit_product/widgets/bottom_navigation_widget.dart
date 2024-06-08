import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';
import '../../../../models/product_model.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SHFRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Nút loại bỏ
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Loại bỏ'),
          ),
          const SizedBox(width: SHFSizes.spaceBtwItems / 2),

          // Nút lưu thay đổi
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => EditProductController.instance.editProduct(product),
              child: const Text('Lưu thay đổi'),
            ),
          ),
        ],
      ),
    );
  }
}
