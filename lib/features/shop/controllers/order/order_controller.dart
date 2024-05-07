import 'package:get/get.dart';
import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/order_model.dart';

class OrderController extends SHFBaseController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepository());

  @override
  Future<List<OrderModel>> fetchItems() async {
    return await _orderRepository.getAllOrders();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.totalAmount.toString().toLowerCase());
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  /// Update Product Status
  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(order.docId, {'status': newStatus.toString()});
      updateItemFromLists(order);
      orderStatus.value = newStatus;
      SHFLoaders.successSnackBar(title: 'Updated', message: 'Order Status Updated');
    } catch (e) {
      SHFLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
