import 'package:get/get.dart';
import '../features/authentication/controllers/admin_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => AdminController(), fenix: true);
  }
}
