import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());

    return SHFRoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Văn bản Thông tin cơ bản
            Text('Thông tin cơ bản', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SHFSizes.spaceBtwItems),

            // Trường nhập Tiêu đề sản phẩm
            TextFormField(
              controller: controller.title,
              validator: (value) => SHFValidator.validationEmptyText('Tiêu đề sản phẩm', value),
              decoration: const InputDecoration(labelText: 'Tiêu đề sản phẩm'),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            // Trường nhập Mô tả sản phẩm
            SizedBox(
              height: 300,
              child: TextFormField(
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                controller: controller.description,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) => SHFValidator.validationEmptyText('Mô tả sản phẩm', value),
                decoration: const InputDecoration(
                  labelText: 'Mô tả sản phẩm',
                  hintText: 'Thêm mô tả sản phẩm của bạn ở đây...',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
