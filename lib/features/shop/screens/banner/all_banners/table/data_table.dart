import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/banner/banner_controller.dart';
import 'table_source.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () {
        // Các mục Danh mục & Hàng đã chọn bị ẩn => Chỉ để cập nhật giao diện => Obx => [ProductRows]
        Visibility(
            visible: false,
            child: Text(controller.filteredItems.length.toString()));
        Visibility(
            visible: false,
            child: Text(controller.selectedRows.length.toString()));

        // Bảng
        return SHFPaginatedDataTable(
          minWidth: 700,
          tableHeight: 900,
          dataRowHeight: 110,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: const [
            DataColumn2(label: Text('Banner')),
            DataColumn2(label: Text('Màn hình chuyển hướng')),
            DataColumn2(label: Text('Hoạt động')),
            DataColumn2(label: Text('Hành động'), fixedWidth: 100),
          ],
          source: BannersRows(),
        );
      },
    );
  }
}
