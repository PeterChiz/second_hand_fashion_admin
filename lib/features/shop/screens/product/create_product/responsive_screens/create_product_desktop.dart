import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../widgets/additional_images.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class CreateProductDesktopScreen extends StatelessWidget {
  const CreateProductDesktopScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());

    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dẫn đường
              const SHFBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Tạo sản phẩm',
                  breadcrumbItems: [SHFRoutes.products, 'Tạo sản phẩm']),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              // Tạo sản phẩm
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

                        // Kho và Giá
                        SHFRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Tiêu đề
                              Text('Điều chỉnh sản phẩm trước khi bán',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: SHFSizes.spaceBtwItems),

                              // Loại sản phẩm
                              const ProductTypeWidget(),
                              const SizedBox(
                                  height: SHFSizes.spaceBtwInputFields),

                              // Kho
                              const ProductStockAndPricing(),
                              const SizedBox(height: SHFSizes.spaceBtwSections),

                              // Thuộc tính
                              ProductAttributes(),
                              const SizedBox(height: SHFSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Biến thể
                        const ProductVariations(),
                      ],
                    ),
                  ),
                  const SizedBox(width: SHFSizes.defaultSpace),

                  // Thanh bên
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
                              Text('Tất cả hình ảnh sản phẩm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: SHFSizes.spaceBtwItems),
                              ProductAdditionalImages(
                                additionalProductImagesURLs:
                                    controller.additionalProductImagesUrls,
                                onTapToAddImages: () =>
                                    controller.selectMultipleProductImages(),
                                onTapToRemoveImage: (index) =>
                                    controller.removeImage(index),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Thương hiệu sản phẩm
                        const ProductBrand(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        // Danh mục sản phẩm
                        const ProductCategories(),
                        const SizedBox(height: SHFSizes.spaceBtwSections),

                        //Sản phẩm có được xuất hiện ở màn hình chính không ?
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
