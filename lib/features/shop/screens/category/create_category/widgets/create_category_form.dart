
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../controllers/category/create_category_controller.dart';
import '../../../../models/category_model.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
    return SHFRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: SHFSizes.sm),
            Text('Create New Category', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: SHFSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: createController.name,
              validator: (value) => SHFValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
            ),

            const SizedBox(height: SHFSizes.spaceBtwInputFields),
            Obx(
              () => categoryController.isLoading.value
                  ? const SHFShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField<CategoryModel>(
                      decoration: const InputDecoration(
                          hintText: 'Parent Category', labelText: 'Parent Category', prefixIcon: Icon(Iconsax.bezier)),
                      onChanged: (newValue) => createController.selectedParent.value = newValue!,
                      items: categoryController.allItems
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(item.name)]),
                              ))
                          .toList(),
                    ),
            ),

            const SizedBox(height: SHFSizes.spaceBtwInputFields * 2),

            // Image Uploader & Featured Checkbox
            Obx(
              () => SHFImageUploader(
                width: 80,
                height: 80,
                image: createController.imageURL.value.isNotEmpty ? createController.imageURL.value : SHFImages.defaultImage,
                imageType: createController.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                onIconButtonPressed: () => createController.pickImage(),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),
            Obx(
              () => CheckboxMenuButton(
                value: createController.isFeatured.value,
                onChanged: (value) => createController.isFeatured.value = value ?? false,
                child: const Text('Featured'),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields * 2),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: createController.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () => createController.createCategory(), child: const Text('Create')),
                      ),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
