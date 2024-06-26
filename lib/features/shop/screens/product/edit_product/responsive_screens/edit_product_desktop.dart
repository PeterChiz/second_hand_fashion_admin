import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../../../../models/product_model.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../create_product/widgets/additional_images.dart';
import '../../create_product/widgets/thumbnail_widget.dart';
import '../../create_product/widgets/visibility_widget.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';

class EditProductDesktopScreen extends StatelessWidget {
  const EditProductDesktopScreen({
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
                heading: 'Chỉnh sửa sản phẩm',
                returnToPreviousScreen: true,
                breadcrumbItems: [SHFRoutes.products, 'Chỉnh sửa sản phẩm'],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Edit Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thông tin cơ bản
                        const ProductTitleAndDescription(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Số lượng & Giá
                        SHFRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Tiêu đề
                              Text('Điều chỉnh sản phẩm trước khi bán', style: Theme.of(context).textTheme.headlineSmall),
                              const SizedBox(height: SHFSizes.spaceBtwItems),

                              // Loại sản phẩm
                              const ProductTypeWidget(),
                              const SizedBox(height: SHFSizes.spaceBtwInputFields),

                              // Số lượng
                              const ProductStockAndPricing(),
                              const SizedBox(height: SHFSizes.spaceBtwSections),

                              // Thuộc tính
                              ProductAttributes(), // Add/Edit/Delete Attributes
                              const SizedBox(height: SHFSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Biến thể
                        const ProductVariations(), // Edit/Delete Variations
                      ],
                    ),
                  ),
                  const SizedBox(width: SHFSizes.defaultSpace),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Hình ảnh sản phẩm
                        const ProductThumbnailImage(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Tất cả hình ảnh sản phẩm
                        SHFRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tất cả hình ảnh sản phẩm', style: Theme.of(context).textTheme.headlineSmall),
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

                        // Thương hiệu sản phẩm
                        const ProductBrand(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Danh mục sản phẩm
                        ProductCategories(product: product),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Sản phẩm có được xuất hiện ở màn hình chính không ?
                        const ProductVisibilityWidget(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
