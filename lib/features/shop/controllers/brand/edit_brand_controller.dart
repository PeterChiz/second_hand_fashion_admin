import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/brands/brand_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/brand_category_model.dart';
import '../../models/brand_model.dart';
import '../../models/category_model.dart';
import '../product/product_controller.dart';
import 'brand_controller.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Khởi tạo Dữ liệu
  void init(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  /// Chuyển đổi Lựa chọn Danh mục
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }

    update();
  }

  /// Phương thức để đặt lại trường
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  /// Chọn Hình Ảnh Đại Diện từ Phương Tiện
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Xử lý các hình ảnh đã chọn
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Đặt hình ảnh đã chọn là hình ảnh chính hoặc thực hiện bất kỳ hành động nào khác
      ImageModel selectedImage = selectedImages.first;
      // Cập nhật hình ảnh chính bằng selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Cập nhật Thương hiệu
  Future<void> updateBrand(BrandModel brand) async {
    try {
      // Bắt đầu Loading
      SHFFullScreenLoader.popUpCircular();

      // Kiểm tra Kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Kiểm tra Validation Form
      if (!formKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Dữ liệu đã được cập nhật
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value || brand.name != name.text.trim() || brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // Ánh xạ Dữ liệu
        brand.image = imageURL.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Gọi Repository để Cập nhật
        await repository.updateBrand(brand);
      }

      // Cập nhật BrandCategories
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Cập nhật Dữ liệu Thương hiệu trong Sản phẩm
      if (isBrandUpdated) await updateBrandInProducts(brand);

      // Cập nhật Tất cả danh sách dữ liệu
      BrandController.instance.updateItemFromLists(brand);

      // Cập nhật Người nghe UI
      update();

      // Loại bỏ Loader
      SHFFullScreenLoader.stopLoading();

      // Thông báo Thành công & Chuyển hướng
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Bản ghi của bạn đã được cập nhật.');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Cập nhật Danh mục của Thương hiệu này
  updateBrandCategories(BrandModel brand) async {
    // Lấy tất cả BrandCategories
    final brandCategories = await repository.getSpecificBrandCategories(brand.id);

    // Ids của các Category được chọn
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

    // Xác định các danh mục cần xóa
    final categoriesToRemove =
    brandCategories.where((existingCategory) => !selectedCategoryIds.contains(existingCategory.categoryId)).toList();

    // Loại bỏ các danh mục không được chọn
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepository.instance.deleteBrandCategory(categoryToRemove.id ?? '');
    }

    // Xác định danh mục mới để thêm
    final newCategoriesToAdd = selectedCategories
        .where((newCategory) => !brandCategories.any((existingCategory) => existingCategory.categoryId == newCategory.id))
        .toList();

    // Thêm danh mục mới
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory = BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
      brandCategory.id = await BrandRepository.instance.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromLists(brand);
  }

  /// Cập nhật Sản phẩm của Thương hiệu này
  updateBrandInProducts(BrandModel brand) async {
    final productController = Get.put(ProductController());

    // Kiểm tra xem có Sản phẩm không, nếu không thì lấy chúng
    if (productController.allItems.isEmpty) {
      await productController.fetchItems();
    }

    // Một khi các sản phẩm đã được lấy, Lấy tất cả sản phẩm của thương hiệu này
    final brandProducts = productController.allItems.where((product) => product.brand != null && product.brand!.id == brand.id).toList();
    if (brandProducts.isNotEmpty) {
      // Cập nhật Thương hiệu trong Sản phẩm
      for (var product in brandProducts) {
        product.brand = brand;
        await ProductRepository.instance.updateProductSpecificValue(product.id, {'Brand': brand.toJson()});
      }

      // Cập nhật thương hiệu trong Danh sách Các Sản phẩm đã lấy cục bộ
      // Để làm: Cập nhật Giá trị Thương hiệu Sản phẩm trong Danh sách Cục bộ --> Chỉ cần bỏ comment dòng bên dưới
      // productController.updateItemFromLists(brand);
    }
  }
}
