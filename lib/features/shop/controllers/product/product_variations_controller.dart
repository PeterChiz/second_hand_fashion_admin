import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../utils/popups/dialogs.dart';
import '../../models/product_variation_model.dart';
import 'product_attributes_controller.dart';

class ProductVariationController extends GetxController {
  // Thể hiện duy nhất
  static ProductVariationController get instance => Get.find();

  // Observable cho trạng thái tải và biến thể sản phẩm
  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;

  // Danh sách để lưu trữ các bộ điều khiển cho mỗi thuộc tính biến thể
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> descriptionControllersList = [];

  // Thể hiện của ProductAttributesController
  final attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Xóa danh sách hiện có
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Khởi tạo bộ điều khiển cho mỗi biến thể
    for (var variation in variations) {
      // Bộ điều khiển cho kho
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] = TextEditingController(text: variation.stock.toString());
      stockControllersList.add(stockControllers);

      // Bộ điều khiển cho giá
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] = TextEditingController(text: variation.price.toString());
      priceControllersList.add(priceControllers);

      // Bộ điều khiển cho giá khuyến mãi
      Map<ProductVariationModel, TextEditingController> salePriceControllers = {};
      salePriceControllers[variation] = TextEditingController(text: variation.salePrice.toString());
      salePriceControllersList.add(salePriceControllers);

      // Bộ điều khiển cho mô tả
      Map<ProductVariationModel, TextEditingController> descriptionControllers = {};
      descriptionControllers[variation] = TextEditingController(text: variation.description);
      descriptionControllersList.add(descriptionControllers);
    }
  }

  // Hàm để xóa biến thể với hộp thoại xác nhận
  void removeVariations(BuildContext context) {
    SHFDialogs.defaultDialog(
      context: context,
      title: 'Xóa biến thể',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  // Hàm để tạo ra biến thể với hộp thoại xác nhận
  void generateVariationsConfirmation(BuildContext context) {
    SHFDialogs.defaultDialog(
      context: context,
      confirmText: 'Tạo',
      title: 'Tạo biến thể',
      content:
      'Sau khi tạo biến thể, bạn không thể thêm thuộc tính nào khác. Để thêm biến thể khác, bạn phải xóa bất kỳ thuộc tính nào.',
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  // Hàm để tạo ra biến thể từ các thuộc tính
  void generateVariationsFromAttributes() {
    // Đóng cửa sổ Popup trước đó
    Get.back();

    final List<ProductVariationModel> variations = [];

    // Kiểm tra xem có thuộc tính nào không
    if (attributesController.productAttributes.isNotEmpty) {
      // Lấy tất cả các kết hợp của giá trị thuộc tính, [[Green, Blue], [Small, Large]]
      final List<List<String>> attributeCombinations =
      getCombinations(attributesController.productAttributes.map((attr) => attr.values ?? <String>[]).toList());

      // Tạo ProductVariationModel cho mỗi kết hợp
      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues =
        Map.fromIterables(attributesController.productAttributes.map((attr) => attr.name ?? ''), combination);

        // Bạn có thể đặt các giá trị mặc định cho các thuộc tính khác nếu cần
        final ProductVariationModel variation = ProductVariationModel(id: UniqueKey().toString(), attributeValues: attributeValues);

        variations.add(variation);

        // Tạo bộ điều khiển
        final Map<ProductVariationModel, TextEditingController> stockControllers = {};
        final Map<ProductVariationModel, TextEditingController> priceControllers = {};
        final Map<ProductVariationModel, TextEditingController> salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController> descriptionControllers = {};

        // Giả sử variation là ProductVariationModel hiện tại của bạn
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        // Thêm các bản đồ vào các danh sách tương ứng của chúng
        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllersList.add(descriptionControllers);
      }
    }

    // Gán các biến thể được tạo ra vào danh sách productVariations
    productVariations.assignAll(variations);
  }

  // Lấy tất cả các kết hợp của các giá trị thuộc tính
  List<List<String>> getCombinations(List<List<String>> lists) {
    // Danh sách kết quả sẽ lưu trữ tất cả các kết hợp
    final List<List<String>> result = [];

    // Bắt đầu kết hợp các thuộc tính từ cái đầu tiên
    combine(lists, 0, <String>[], result);

    // Trả về danh sách kết quả cuối cùng của các kết hợp
    return result;
  }

  // Hàm trợ giúp để kết hợp các giá trị thuộc tính một cách đệ quy
  void combine(List<List<String>> lists, int index, List<String> current, List<List<String>> result) {
    // Nếu chúng ta đã đến cuối các danh sách, thêm kết hợp hiện tại vào kết quả
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    // Duyệt qua các giá trị của thuộc tính hiện tại
    for (final item in lists[index]) {
      // Tạo một danh sách được cập nhật với giá trị hiện tại được thêm vào
      final List<String> updated = List.from(current)..add(item);

      // Kết hợp một cách đệ quy với thuộc tính tiếp theo
      combine(lists, index + 1, updated, result);
    }
  }

  // Hàm để đặt lại tất cả các giá trị
  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }
}
