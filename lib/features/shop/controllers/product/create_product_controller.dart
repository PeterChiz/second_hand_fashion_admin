import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../features/shop/controllers/product/product_attributes_controller.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/controllers/product/product_images_controller.dart';
import '../../../../features/shop/controllers/product/product_variations_controller.dart';
import '../../../../features/shop/models/brand_model.dart';
import '../../../../features/shop/models/category_model.dart';
import '../../../../features/shop/models/product_category_model.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class CreateProductController extends GetxController {
  // Đối tượng singleton
  static CreateProductController get instance => Get.find();

  // Các observables cho trạng thái loading và chi tiết sản phẩm
  final isLoading = false.obs;
  final productType = ProductType.single.obs;

  // Controllers và keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Controllers cho việc chỉnh sửa văn bản
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables cho thương hiệu và danh mục được chọn
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Cờ để theo dõi các nhiệm vụ khác nhau
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Hàm để tạo sản phẩm mới
  Future<void> createProduct() async {
    try {
      // Hiển thị hộp thoại tiến trình
      showProgressDialog();

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Validate form tiêu đề và mô tả
      if (!titleDescriptionFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Validate form tồn kho và giá nếu ProductType = Single
      if (productType.value == ProductType.single && !stockPriceFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Đảm bảo đã chọn thương hiệu
      if (selectedBrand.value == null) throw 'Chọn Thương hiệu cho sản phẩm này';

      // Kiểm tra dữ liệu biến thể nếu ProductType = Variable
      if (productType.value == ProductType.variable && ProductVariationController.instance.productVariations.isEmpty){
        throw 'Không có biến thể nào cho Loại Sản phẩm Biến thể. Tạo một số biến thể hoặc thay đổi Loại Sản phẩm.';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController.instance.productVariations.any((element) =>
        element.price.isNaN ||
            element.price < 0 ||
            element.salePrice.isNaN ||
            element.salePrice < 0 ||
            element.stock.isNaN ||
            element.stock < 0 ||
            element.image.value.isEmpty);

        if (variationCheckFailed) throw 'Dữ liệu biến thể không chính xác. Vui lòng kiểm tra lại các biến thể';
      }

      // Tải ảnh đại diện sản phẩm lên
      thumbnailUploader.value = true;
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) throw 'Chọn ảnh đại diện cho sản phẩm';

      // Tải ảnh phụ sản phẩm lên
      additionalImagesUploader.value = true;

      // Ảnh biến thể sản phẩm
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // Nếu quản trị viên đã thêm biến thể và sau đó thay đổi Loại Sản phẩm, xóa tất cả biến thể
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Ánh xạ dữ liệu sản phẩm thành ProductModel
      final newRecord = ProductModel(
        id: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
        productAttributes: ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
      );

      // Gọi Repository để tạo Sản phẩm mới
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      // Đăng ký danh mục sản phẩm nếu có
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Lỗi lưu dữ liệu. Thử lại';

        // Lặp qua các Danh mục Sản phẩm đã chọn
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Ánh xạ Dữ liệu
          final productCategory = ProductCategoryModel(productId: newRecord.id, categoryId: category.id);
          await ProductRepository.instance.createProductCategory(productCategory);
        }
      }

      // Cập nhật danh sách Sản phẩm
      ProductController.instance.addItemToLists(newRecord);

      // Đóng hộp thoại tiến trình
      SHFFullScreenLoader.stopLoading();

      // Hiển thị hộp thoại Thành công
      showCompletionDialog();
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Thông báo', message: e.toString());
    }
  }

  // Đặt lại các giá trị và cờ của biểu mẫu
  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductVariationController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

    // Đặt lại cờ Tải lên
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  // Hiển thị hộp thoại tiến trình
  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Đang tạo Sản phẩm'),
          content: Obx(
                () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(SHFImages.creatingProductIllustration, height: 200, width: 200),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                buildCheckbox('Ảnh đại diện', thumbnailUploader),
                buildCheckbox('Ảnh Phụ', additionalImagesUploader),
                buildCheckbox('Dữ liệu Sản phẩm, Thuộc tính & Biến thể', productDataUploader),
                buildCheckbox('Danh mục Sản phẩm', categoriesRelationshipUploader),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                const Text('Đang tạo sản phẩm của bạn...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Xây dựng widget checkbox
  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: SHFSizes.spaceBtwItems),
        Text(label),
      ],
    );
  }

  // Hiển thị hộp thoại hoàn thành
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Chúc mừng'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Đi đến Sản phẩm'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SHFImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: SHFSizes.spaceBtwItems),
            Text('Chúc mừng', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: SHFSizes.spaceBtwItems),
            const Text('Sản phẩm của bạn đã được tạo'),
          ],
        ),
      ),
    );
  }
}
