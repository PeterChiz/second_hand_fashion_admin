import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/order/order_controller.dart';
import 'table_source.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(
          () {
        // Các đơn hàng & Rows được chọn được ẩn => Cập nhật UI => Obx => [ProductRows]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Table
        return SHFPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: const Text('Mã đơn hàng'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text('Ngày')),
            const DataColumn2(label: Text('Số lượng')),
            const DataColumn2(label: Text('Trạng thái'), fixedWidth: null),
            const DataColumn2(label: Text('Số tiền')),
            const DataColumn2(label: Text('Hành động'), fixedWidth: 100),
          ],
          source: OrderRows(),
        );
      },
    );
  }
}
