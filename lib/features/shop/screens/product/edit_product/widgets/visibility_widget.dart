import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return SHFRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề Hiển Thị
          Text('Hiển Thị', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          // Các nút radio cho việc hiển thị sản phẩm
          Obx(
                () => Column(
              children: [
                _buildVisibilityRadioButton(controller, ProductVisibility.published, 'Xuất bản'),
                _buildVisibilityRadioButton(controller, ProductVisibility.hidden, 'Ẩn'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Phương thức hỗ trợ để tạo nút radio cho việc hiển thị sản phẩm
  Widget _buildVisibilityRadioButton(EditProductController controller, ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: controller.productVisibility.value,
      onChanged: (selection) => controller.productVisibility.value = selection ?? ProductVisibility.hidden,
      child: Text(label),
    );
  }
}
