import 'package:get/get.dart';
import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';
import '../order/order_controller.dart';

class ProductController extends SHFBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    // Bạn có thể muốn kiểm tra xem có bất kỳ đơn hàng nào của sản phẩm này tồn tại không, hãy xóa chúng trước
    final orderController = Get.put(OrderController());

    // Nếu không có đơn hàng nào được lấy, Hãy lấy chúng trước
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    // Kiểm tra xem có bất kỳ đơn hàng nào chứa id sản phẩm này không
    final orderExists = orderController.allItems.any((element) => element.items.any((element) => element.productId == item.id));

    if (orderExists) {
      SHFLoaders.warningSnackBar(title: 'Tồn tại các phụ thuộc', message: 'Để Xóa Sản phẩm này, Hãy Xóa các Đơn đặt hàng phụ thuộc trước.');
      return;
    }
    await _productRepository.deleteProduct(item);
  }

  /// Mã liên quan đến việc sắp xếp
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (ProductModel product) => product.title.toLowerCase());
  }

  /// Mã liên quan đến việc sắp xếp
  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (ProductModel product) => product.title.toLowerCase());
  }

  /// Mã liên quan đến việc sắp xếp
  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (ProductModel product) => product.stock);
  }

  /// Lấy giá sản phẩm hoặc phạm vi giá cho các biến thể.
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // Nếu không có biến thể tồn tại, trả về giá đơn giản hoặc giá giảm giá
    if (product.productType == ProductType.single.toString() || product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price).toString();
    } else {
      // Tính toán giá nhỏ nhất và lớn nhất trong số các biến thể
      for (var variation in product.productVariations!) {
        // Xác định giá cần xem xét (giá giảm giá nếu có, nếu không thì giá thông thường)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Cập nhật giá nhỏ nhất và lớn nhất
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // Nếu giá nhỏ nhất và lớn nhất giống nhau, trả về một giá duy nhất
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Nếu không, trả về một phạm vi giá
        return '$smallestPriceđ - $largestPrice';
      }
    }
  }



  /// -- Tính tổng số lượng sản phẩm
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.stock).toString();
  }

  /// -- Kiểm tra Trạng thái Hàng tồn kho
  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'Còn hàng' : 'Hết hàng';
  }
}
