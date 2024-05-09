import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/order/order_controller.dart';
import 'table_source.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(
      () {
        // Các đơn hàng & Các hàng được chọn được ẩn => Chỉ để cập nhật giao diện người dùng => Obx => [ProductRows]
        Visibility(
            visible: false,
            child: Text(controller.filteredItems.length.toString()));
        Visibility(
            visible: false,
            child: Text(controller.selectedRows.length.toString()));

        // Bảng
        return SHFPaginatedDataTable(
          minWidth: 700,
          dataRowHeight: SHFSizes.xl * 1.2,
          tableHeight: 500,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: const Text('Mã đơn hàng'),
                onSort: (columnIndex, ascending) =>
                    controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text('Ngày')),
            const DataColumn2(label: Text('Sản phẩm')),
            DataColumn2(
                label: const Text('Trạng thái'),
                fixedWidth:
                    SHFDeviceUtils.isMobileScreen(context) ? 120 : null),
            const DataColumn2(label: Text('Số tiền')),
          ],
          source: OrderRows(),
        );
      },
    );
  }
}
