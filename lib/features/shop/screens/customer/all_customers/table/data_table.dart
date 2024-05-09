import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/customer/customer_controller.dart';
import 'table_source.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Obx(
          () {
        // Khách hàng và hàng được chọn được ẩn => Chỉ để cập nhật giao diện UI => Obx => [Các hàng sản phẩm]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Bảng
        return SHFPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: const Text('Khách hàng'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Email')),
            const DataColumn2(label: Text('Số điện thoại')),
            const DataColumn2(label: Text('Đã đăng ký')),
            const DataColumn2(label: Text('Hành động'), fixedWidth: 100),
          ],
          source: CustomerRows(),
        );
      },
    );
  }
}
