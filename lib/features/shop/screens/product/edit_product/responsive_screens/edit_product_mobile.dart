import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../../../../models/product_model.dart';
import '../../create_product/widgets/additional_images.dart';
import '../../create_product/widgets/thumbnail_widget.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class EditProductMobileScreen extends StatelessWidget {
  const EditProductMobileScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());

    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const SHFBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [SHFRoutes.products, 'Edit Product'],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Edit Product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTitleAndDescription(),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Stock & Pricing
                  SHFRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading
                        Text('Stock & Pricing', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: SHFSizes.spaceBtwItems),

                        // Product Type
                        const ProductTypeWidget(),
                        const SizedBox(height: SHFSizes.spaceBtwInputFields),

                        // Stock
                        const ProductStockAndPricing(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Attributes
                        ProductAttributes(), // Edit/Delete Attributes
                        const SizedBox(height: SHFSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Variations
                  const ProductVariations(), // Edit/Delete Variations
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Sidebar
                  const ProductThumbnailImage(),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Product Images
                  SHFRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('All Product Images', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: SHFSizes.spaceBtwItems),
                        ProductAdditionalImages(
                          additionalProductImagesURLs: controller.additionalProductImagesUrls,
                          onTapToAddImages: () => controller.selectMultipleProductImages(),
                          onTapToRemoveImage: (index) => controller.removeImage(index),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Product Brand
                  const ProductBrand(),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Product Categories
                  ProductCategories(product: product),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  // Product Visibility
                  const ProductVisibilityWidget(),
                  const SizedBox(height: SHFSizes.spaceBtwSections),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
