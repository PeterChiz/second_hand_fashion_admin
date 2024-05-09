import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/address/address_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/order_model.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressesLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  /// -- Tải các đơn hàng của khách hàng
  Future<void> getCustomerOrders() async {
    try {
      // Hiển thị trình tải trong khi tải các đơn hàng
      ordersLoading.value = true;

      // Lấy các đơn hàng và địa chỉ của khách hàng
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders = await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }

      // Cập nhật danh sách các đơn hàng
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      // Lọc các đơn hàng nổi bật
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      // Đặt tất cả các hàng là false [Chưa được chọn] & Chuyển đổi khi cần
      selectedRows.assignAll(List.generate(customer.value.orders != null ? customer.value.orders!.length : 0, (index) => false));
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  /// -- Tải địa chỉ của khách hàng
  Future<void> getCustomerAddresses() async {
    try {
      // Hiển thị trình tải trong khi tải địa chỉ
      addressesLoading.value = true;

      // Lấy các đơn hàng và địa chỉ của khách hàng
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses = await addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }

  /// -- Bộ lọc truy vấn tìm kiếm
  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
      allCustomerOrders.where((customer) =>
      customer.id.toLowerCase().contains(query.toLowerCase()) || customer.orderDate.toString().contains(query.toLowerCase())),
    );

    // Thông báo cho người nghe về sự thay đổi
    update();
  }

  /// Mã sắp xếp liên quan
  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if (ascending) {
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      } else {
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;

    update();
  }

}
