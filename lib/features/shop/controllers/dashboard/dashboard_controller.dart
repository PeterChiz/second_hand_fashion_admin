import 'package:get/get.dart';
import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/order_model.dart';
import '../order/order_controller.dart';

class DashboardController extends SHFBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  @override
  Future<List<OrderModel>> fetchItems() async {
    // Lấy đơn hàng nếu trống
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    // Đặt lại giá trị bán hàng hàng tuần thành 0
    weeklySales.value = List<double>.filled(7, 0.0);

    // Tính toán doanh số hàng tuần
    _calculateWeeklySales();

    // Tính toán số lượng trạng thái đơn hàng
    _calculateOrderStatusData();

    return orderController.allItems;
  }

  // Tính toán doanh số hàng tuần
  void _calculateWeeklySales() {
    for (var order in orderController.allItems) {
      final DateTime orderWeekStart = SHFHelperFunctions.getStartOfWeek(order.orderDate);

      // Kiểm tra xem đơn hàng có trong tuần hiện tại không
      if (orderWeekStart.isBefore(DateTime.now()) && orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7; // Điều chỉnh chỉ mục dựa trên biểu diễn ngày trong tuần của DateTime

        // Đảm bảo chỉ mục là không âm
        index = index < 0 ? index + 7 : index;

        print('Đơn hàng ngày: ${order.orderDate}, Ngày đầu tiên của tuần hiện tại: $orderWeekStart, Index: $index');

        weeklySales[index] += (order.totalAmount) / 1000;
      }
    }

    print('Bán hàng hàng tuần: $weeklySales');

  }

  // Gọi hàm này để tính toán số lượng trạng thái đơn hàng
  void _calculateOrderStatusData() {
    // Đặt lại dữ liệu trạng thái
    orderStatusData.clear();

    // Map để lưu tổng số tiền cho mỗi trạng thái
    totalAmounts.value = { for (var status in OrderStatus.values) status : 0.0 };

    for (var order in orderController.allItems) {
      // Cập nhật số lượng trạng thái
      final OrderStatus status = order.status;
      final String displayStatus = getDisplayStatusName(status);
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Tính tổng số tiền cho mỗi trạng thái
      totalAmounts[status] = totalAmounts[status]! + order.totalAmount;
    }

    print('Dữ liệu trạng thái đơn hàng: $orderStatusData');

  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Chờ xử lý';
      case OrderStatus.processing:
        return 'Đang xử lý';
      case OrderStatus.shipped:
        return 'Đã gửi';
      case OrderStatus.delivered:
        return 'Đang giao hàng';
      case OrderStatus.cancelled:
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  @override
  Future<void> deleteItem(OrderModel item) async {}

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;
}
