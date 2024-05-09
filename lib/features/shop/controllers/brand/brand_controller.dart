import 'package:get/get.dart';
import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/brands/brand_repository.dart';
import '../../models/brand_model.dart';
import '../category/category_controller.dart';

class BrandController extends SHFBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Lấy các thương hiệu
    final fetchedBrands = await _brandRepository.getAllBrands();

    // Lấy Dữ liệu Mối quan hệ Thương hiệu Danh mục
    final fetchedBrandCategories = await _brandRepository.getAllBrandCategories();

    // Lấy Tất cả các Danh mục nếu dữ liệu chưa tồn tại
    if (categoryController.allItems.isNotEmpty) await categoryController.fetchItems();

    // Duyệt qua tất cả các thương hiệu và lấy các danh mục của mỗi thương hiệu
    for (var brand in fetchedBrands) {
      // Trích xuất các Id danh mục từ các tài liệu
      List<String> categoryIds = fetchedBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brand.brandCategories = categoryController.allItems.where((category) => categoryIds.contains(category.id)).toList();
    }

    return fetchedBrands;
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) async {
    await _brandRepository.deleteBrand(item);
  }
}
