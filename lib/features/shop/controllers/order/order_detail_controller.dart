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

  /// -- Load customer orders
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      // Show loader while loading categories
      loading.value = true;
      // Fetch customer orders & addresses
      final user = await UserRepository.instance.fetchUserDetails(order.value.userId);

      customer.value = user;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
