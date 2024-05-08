
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/banner/create_banner_controller.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return SHFRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: SHFSizes.sm),
            Text('Tạo Banner mới', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: SHFSizes.spaceBtwSections),

            // Image Uploader & Featured Checkbox
            Column(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: SHFRoundedImage(
                      width: 400,
                      height: 200,
                      backgroundColor: SHFColors.primaryBackground,
                      image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : SHFImages.defaultImage,
                      imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                    ),
                  ),
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                TextButton(onPressed: () => controller.pickImage(), child: const Text('Chọn ảnh')),
              ],
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            Text('Làm cho Banner của bạn hoạt động hoặc không hoạt động', style: Theme.of(context).textTheme.bodyMedium),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged: (value) => controller.isActive.value = value ?? false,
                child: const Text('Active'),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            // Dropdown Menu Screens
            Obx(
              () {
                return DropdownButton<String>(
                  value: controller.targetScreen.value,
                  onChanged: (String? newValue) => controller.targetScreen.value = newValue!,
                  items: AppScreens.allAppScreenItems.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields * 2),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: controller.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () => controller.createBanner(), child: const Text('Tạo')),
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
