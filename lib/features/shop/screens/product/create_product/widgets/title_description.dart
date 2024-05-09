import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());

    return SHFRoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text
            Text('Thông Tin Cơ Bản', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SHFSizes.spaceBtwItems),

            // Product Title Input Field
            TextFormField(
              controller: controller.title,
              validator: (value) => SHFValidator.validationEmptyText('Tiêu đề Sản phẩm', value),
              decoration: const InputDecoration(labelText: 'Tiêu đề Sản phẩm'),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            // Product Description Input Field
            SizedBox(
              height: 300,
              child: TextFormField(
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                controller: controller.description,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) => SHFValidator.validationEmptyText('Mô tả Sản phẩm', value),
                decoration: const InputDecoration(
                  labelText: 'Mô tả Sản phẩm',
                  hintText: 'Thêm mô tả của bạn ở đây...',
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
