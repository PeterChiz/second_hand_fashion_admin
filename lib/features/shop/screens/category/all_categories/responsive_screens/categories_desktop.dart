import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';
import '../table/data_table.dart';
import '../widgets/table_header.dart';

class CategoriesDesktopScreen extends StatelessWidget {
  const CategoriesDesktopScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              const SHFBreadcrumbsWithHeading(
                  heading: 'Danh mục', breadcrumbItems: ['Danh mục']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Thân bảng
              Obx(() {
                // Hiển thị Trình tải
                if (controller.isLoading.value) return const SHFLoaderAnimation();

                return const SHFRoundedContainer(
                  child: Column(
                    children: [
                      // Tiêu đề Bảng
                      CategoryTableHeader(),
                      SizedBox(height: SHFSizes.spaceBtwItems),

                      // Bảng
                      CategoryTable(),
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
