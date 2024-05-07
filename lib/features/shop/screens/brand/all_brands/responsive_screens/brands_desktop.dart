import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';
import '../table/data_table.dart';
import '../widgets/table_header.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

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
              // Breadcrumbs
              const SHFBreadcrumbsWithHeading(heading: 'Brands', breadcrumbItems: ['Brands']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Table Body
              Obx(() {
                // Show Loader
                if (controller.isLoading.value) return const SHFLoaderAnimation();

                return const SHFRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      BrandTableHeader(),
                      SizedBox(height: SHFSizes.spaceBtwItems),

                      // Table
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
