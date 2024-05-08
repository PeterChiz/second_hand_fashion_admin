// Import các controllers, models, và utility classes cần thiết
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import '../category/category_controller.dart';

class EditProductController extends GetxController {
  // Thể hiện duy nhất
  static EditProductController get instance => Get.find();

  // Observable cho trạng thái tải và chi tiết sản phẩm
  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers và keys
  final variationsController = Get.put(ProductVariationController());
  final attributesController = Get.put(ProductAttributesController());
  final imagesController = Get.put(ProductImagesController());
  final productRepository = Get.put(ProductRepository());
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Text editing controllers cho các trường nhập
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables cho thương hiệu và các danh mục được chọn
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  // Flags để theo dõi các nhiệm vụ khác nhau
  RxBool thumbnailUploader = true.obs;
  RxBool productDataUploader = false.obs;
  RxBool additionalImagesUploader = true.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Khởi tạo dữ liệu sản phẩm
  void initProductData(ProductModel product) {
    try {
      isLoading.value = true; // Đặt trạng thái tải khi khởi tạo dữ liệu

      // Thông tin cơ bản
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString() ? ProductType.single : ProductType.variable;

      // Kho & Giá (giả sử productType và productVisibility được xử lý ở đâu đó)
      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Thương hiệu sản phẩm
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      // Ảnh đại diện và ảnh sản phẩm
      if (product.images != null) {
        // Đặt ảnh đầu tiên là ảnh đại diện
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;

        // Thêm các ảnh vào additionalProducSHFImagesUrl
        imagesController.additionalProductImagesUrls.assignAll(product.images ?? []);
      }

      // Thuộc tính và biến thể sản phẩm (giả sử bạn có một phương thức để lấy biến thể trong ProductVariationController)
      attributesController.productAttributes.assignAll(product.productAttributes ?? []);
      variationsController.productVariations.assignAll(product.productVariations ?? []);
      variationsController.initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false; // Đặt lại trạng thái tải sau khi khởi tạo

      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  // Load danh mục đã chọn
  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;
    // Các danh mục sản phẩm
    final productCategories = await productRepository.getProductCategories(productId);
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) await categoriesController.fetchItems();

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories = categoriesController.allItems.where((element) => categoriesIds.contains(element.id)).toList();
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  // Chỉnh sửa sản phẩm
  Future<void> editProduct(ProductModel product) async {
    try {
      showProgressDialog(); // Hiển thị hộp thoại tiến trình

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      if (!titleDescriptionFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      if (productType.value == ProductType.single && !stockPriceFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      if (selectedBrand.value == null) throw 'Select Brand for this product';

      if (productType.value == ProductType.variable && ProductVariationController.instance.productVariations.isEmpty) {
        throw 'Không có biến thể cho Loại Sản phẩm Biến thể. Tạo một số biến thể hoặc thay đổi loại Sản phẩm.';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController.instance.productVariations.any(
              (element) =>
          element.price.isNaN ||
              element.price < 0 ||
              element.salePrice.isNaN ||
              element.salePrice < 0 ||
              element.stock.isNaN ||
              element.stock < 0,
        );

        if (variationCheckFailed) throw 'Dữ liệu biến thể không chính xác. Vui lòng kiểm tra lại biến thể';
      }

      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null || imagesController.selectedThumbnailImageUrl.value!.isEmpty) {
        throw 'Upload Product Thumbnail Image';
      }

      var variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      product.sku = '';
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImagesUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
      product.productAttributes = ProductAttributesController.instance.productAttributes;
      product.productVariations = variations;

      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(product);

      if (selectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        List<String> existingCategoryIds = alreadyAddedCategories.map((category) => category.id).toList();

        for (var category in selectedCategories) {
          if (!existingCategoryIds.contains(category.id)) {
            final productCategory = ProductCategoryModel(productId: product.id, categoryId: category.id);
            await ProductRepository.instance.createProductCategory(productCategory);
          }
        }

        for (var existingCategoryId in existingCategoryIds) {
          if (!selectedCategories.any((category) => category.id == existingCategoryId)) {
            await ProductRepository.instance.removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      ProductController.instance.updateItemFromLists(product);

      SHFFullScreenLoader.stopLoading();

      showCompletionDialog();
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Đặt lại các giá trị của biểu mẫu và cờ
  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
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
          title: const Text('Updating Product'),
          content: Obx(
                () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(SHFImages.creatingProductIllustration, height: 200, width: 200),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                buildCheckbox('Thumbnail Image', thumbnailUploader),
                buildCheckbox('Additional Images', additionalImagesUploader),
                buildCheckbox('Product Data, Attributes & Variations', productDataUploader),
                buildCheckbox('Product Categories', categoriesRelationshipUploader),
                const SizedBox(height: SHFSizes.spaceBtwItems),
                const Text('Sit Tight, Your product is uploading...'),
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
        title: const Text('Congratulations'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Go to Products'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(SHFImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: SHFSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: SHFSizes.spaceBtwItems),
            const Text('Your Product has been Created'),
          ],
        ),
      ),
    );
  }
}
