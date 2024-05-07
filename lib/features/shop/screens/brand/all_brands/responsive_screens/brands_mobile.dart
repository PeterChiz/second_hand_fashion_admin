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
  const BrandsMobileScreen({super.key});

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
              const SHFBreadcrumbsWithHeading(heading: 'Categories', breadcrumbItems: ['Categories']),
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
