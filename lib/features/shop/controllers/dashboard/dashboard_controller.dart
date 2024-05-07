
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
    // Fetch Order if empty
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    // Reset weeklySales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);

    // Calculate weekly sales
    _calculateWeeklySales();

    // Calculate Order Status counts
    _calculateOrderStatusData();

    return orderController.allItems;
  }

  // Calculate weekly sales
  void _calculateWeeklySales() {
    for (var order in orderController.allItems) {
      final DateTime orderWeekStart = SHFHelperFunctions.getStartOfWeek(order.orderDate);

      // Check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) && orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7; // Adjust index based on DateTime weekday representation

        // Ensure the index is non-negative
        index = index < 0 ? index + 7 : index;

        print('OrderDate: ${order.orderDate}, CurrentWeekDay: $orderWeekStart, Index: $index');

        weeklySales[index] += order.totalAmount;
      }
    }

    print('Weekly Sales: $weeklySales');
  }

  // Call this function to calculate Order Status counts
  void _calculateOrderStatusData() {
    // Reset status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmounts.value = { for (var status in OrderStatus.values) status : 0.0 };

    for (var order in orderController.allItems) {
      // Update status count
      final OrderStatus status = order.status;
      final String displayStatus = getDisplayStatusName(status);
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Calculate total amounts for each status
      totalAmounts[status] = totalAmounts[status]! + order.totalAmount;
    }

    print('Order Status Data: $orderStatusData');
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  @override
  Future<void> deleteItem(OrderModel item) async {}

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;
}
