
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';
import 'table_source.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(
      () {
        // Khách Hàng & Các Hàng Được Chọn Đã Ẩn => Cập Nhật Giao Diện Người Dùng => Obx => [Các Hàng Sản Phẩm]
        Visibility(visible: false, child: Text(controller.filteredCustomerOrders.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Table
        return SHFPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: const Text('Mã đơn hàng'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text('Ngày đặt')),
            const DataColumn2(label: Text('Số lượng')),
            DataColumn2(label: const Text('Trạng thái'), fixedWidth: SHFDeviceUtils.isMobileScreen(context) ? 100 : null),
            const DataColumn2(label: Text('Số tiền'), numeric: true),
          ],
          source: CustomerOrdersRows(),
        );
      },
    );
  }
}
