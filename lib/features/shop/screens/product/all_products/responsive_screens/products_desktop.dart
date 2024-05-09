import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_controller.dart';
import '../table/products_table.dart';
import '../widgets/table_header.dart';

class ProductsDesktopScreen extends StatelessWidget {
  const ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SHFBreadcrumbsWithHeading(heading: 'Sản phẩm', breadcrumbItems: ['Sản phẩm']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Table Body
              Obx(() {
                // Show Loader
                if (controller.isLoading.value) return const SHFLoaderAnimation();

                return const SHFRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      ProductTableHeader(),
                      SizedBox(height: SHFSizes.spaceBtwItems),

                      // Table
                      ProductsTable(),
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
