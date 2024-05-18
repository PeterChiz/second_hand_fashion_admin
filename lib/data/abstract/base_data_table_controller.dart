import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';

/// Một lớp controller chung để quản lý các bảng dữ liệu bằng cách sử dụng GetX state management.
/// Lớp này cung cấp các chức năng chung để xử lý các bảng dữ liệu, bao gồm lấy, cập nhật và xóa mục.
abstract class SHFBaseController<S> extends GetxController {
  RxBool isLoading = true.obs; // Observables để quản lý trạng thái tải
  RxInt sortColumnIndex = 1.obs; // Observable để theo dõi chỉ mục của cột để sắp xếp
  RxList<S> allItems = <S>[].obs; // Danh sách quan sát để lưu trữ tất cả các mục
  RxBool sortAscending = true.obs; // Observable để theo dõi thứ tự sắp xếp (tăng dần hoặc giảm dần)
  RxList<S> filteredItems = <S>[].obs; // Danh sách quan sát để lưu trữ các mục đã lọc
  RxList<bool> selectedRows = <bool>[].obs; // Danh sách quan sát để lưu trữ các hàng đã chọn
  final searchTextController = TextEditingController(); // Controller để xử lý nhập văn bản tìm kiếm

  @override
  void onInit() {
    fetchData(); // Khởi tạo việc lấy dữ liệu khi controller được khởi tạo
    super.onInit();
  }

  /// Phương thức trừu tượng để được thực hiện bởi các lớp con để lấy các mục.
  Future<List<S>> fetchItems();

  /// Phương thức trừu tượng để được thực hiện bởi các lớp con để xóa một mục.
  Future<void> deleteItem(S item);

  /// Phương thức chung để lấy dữ liệu.
  Future<void> fetchData() async {
    try {
      isLoading.value = true; // Đặt trạng thái tải là true
      List<S> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems(); // Lấy các mục (sẽ được thực hiện trong các lớp con)
      }
      allItems.assignAll(fetchedItems); // Gán các mục đã lấy được vào danh sách allItems
      filteredItems.assignAll(allItems); // Ban đầu, đặt các mục đã lọc là tất cả các mục
      selectedRows.assignAll(List.generate(allItems.length, (index) => false)); // Khởi tạo các hàng đã chọn
    } catch (e) {
      // Xử lý lỗi (sẽ được thực hiện trong các lớp con)
    } finally {
      isLoading.value = false; // Đặt trạng thái tải là false, bất kể thành công hay không
    }
  }

  /// Phương thức chung để tìm kiếm dựa trên một truy vấn
  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)),
    );

    // Thông báo cho người nghe về sự thay đổi
    update();
  }

  /// Phương thức trừu tượng để được thực hiện bởi các lớp con để kiểm tra xem một mục có chứa truy vấn tìm kiếm không.
  bool containsSearchQuery(S item, String query);

  /// Phương thức chung để sắp xếp các mục theo một thuộc tính
  void sortByProperty(int sortColumnIndex, bool ascending, Function(S) property) {
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;

    update();
  }

  /// Phương thức để thêm một mục vào danh sách.
  void addItemToLists(S item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false)); // Khởi tạo các hàng đã chọn
    allItems.refresh(); // Làm mới giao diện người dùng để phản ánh các thay đổi
  }

  /// Phương thức để cập nhật một mục trong danh sách.
  void updateItemFromLists(S item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;

    allItems.refresh(); // Làm mới giao diện người dùng để phản ánh các thay đổi
  }

  /// Phương thức để xóa một mục khỏi danh sách.
  void removeItemFromLists(S item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false)); // Khởi tạo các hàng đã chọn

    update(); // Kích hoạt cập nhật giao diện người dùng
  }

  /// Phương thức chung để xác nhận xóa và thực hiện xóa.
  Future<void> confirmAndDeleteItem(S item) async {
    try {
      // Hiển thị hộp thoại xác nhận
      Get.defaultDialog(
        title: 'Xóa mục',
        content: const Text('Bạn có chắc chắn muốn xóa mục này không?'),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
            onPressed: () async {
              await deleteOnConfirm(item);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: SHFSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.buttonRadius * 5)),
            ),
            child: const Text('Ok'),
          ),
        ),
        cancel: SizedBox(
          width: 80,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: SHFSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SHFSizes.buttonRadius * 5)),
            ),
            child: const Text('Hủy'),
          ),
        ),
      );
    } catch (e) {
      // Xử lý lỗi (sẽ được thực hiện trong các lớp con)
    }
  }

  /// Phương thức được thực hiện bởi các lớp con để xác nhận trước khi xóa một mục.
  Future<void> deleteOnConfirm(S item) async {
    try {
      // Ẩn Hộp thoại Xác nhận
      SHFFullScreenLoader.stopLoading();

      // Bắt đầu bộ lọc
      SHFFullScreenLoader.popUpCircular();

      // Xóa dữ liệu Firestore
      await deleteItem(item);

      removeItemFromLists(item);

      update();

      SHFFullScreenLoader.stopLoading();
      SHFLoaders.successSnackBar(title: 'Đã xóa mục', message: 'Mục của bạn đã được xóa');
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    }
  }
}
