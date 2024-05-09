import 'package:get/get.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/order_model.dart';

class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// -- Tải thông tin khách hàng của đơn hàng hiện tại
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      // Hiển thị trình tải trong khi tải danh sách đơn hàng
      loading.value = true;
      // Lấy thông tin khách hàng & địa chỉ từ đơn hàng
      final user = await UserRepository.instance.fetchUserDetails(order.value.userId);

      customer.value = user;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
