import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';
import '../table/data_table.dart';
import '../widgets/table_header.dart';

class BrandsMobileScreen extends StatelessWidget {
  const BrandsMobileScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Đường dẫn
              const SHFBreadcrumbsWithHeading(heading: 'Danh mục', breadcrumbItems: ['Danh mục']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Nội dung Bảng
              Obx(() {
                // Hiển thị Loader
                if (controller.isLoading.value) return const SHFLoaderAnimation();

                return SHFRoundedContainer(
                  child: Column(
                    children: [
                      // Tiêu đề Bảng
                      BrandTableHeader(),
                      SizedBox(height: SHFSizes.spaceBtwItems),

                      // Bảng
                      BrandTable(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
