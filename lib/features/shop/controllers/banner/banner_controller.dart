import 'package:get/get.dart';
import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/banners/banners_repository.dart';
import '../../models/banner_model.dart';

class BannerController extends SHFBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  /// Phương thức để định dạng một chuỗi tuyến đường.
  String formatRoute(String route) {
    if (route.isEmpty) return '';
    // Xóa dấu '/'
    String formatted = route.substring(1);

    // Viết hoa ký tự đầu tiên
    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }
}
