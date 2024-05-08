import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../controllers/media_controller.dart';
import '../widgets/media_content.dart';
import '../widgets/media_uploader.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SHFBreadcrumbsWithHeading(heading: 'Phương tiện truyền thông', breadcrumbItems: ['Media']),
                  SizedBox(
                    width: SHFSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.showImagesUploaderSection.value = !controller.showImagesUploaderSection.value,
                      icon: const Icon(Iconsax.cloud_add),
                      label: const Text('Đăng tải hình ảnh'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Upload Area
              const MediaUploader(),

              // Media
              MediaContent(),
            ],
          ),
        ),
      ),
    );
  }
}