import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/brand/brand_controller.dart';
import 'table_source.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Obx(
          () {
        // Các Hạng mục và Hàng đã Chọn được Ẩn => Chỉ để cập nhật giao diện => Obx => [Các hàng sản phẩm]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        final lgTable = controller.filteredItems.any((element) => element.brandCategories != null && element.brandCategories!.length > 2);
        // Bảng
        return SHFPaginatedDataTable(
          minWidth: 700,
          dataRowHeight: lgTable ? 96 : 64,
          tableHeight: lgTable ? 96 * 11.5 : 760,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: const Text('Thương hiệu'),
                fixedWidth:  200,
                onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Danh mục')),
            const DataColumn2(label: Text('Nổi bật'), fixedWidth: 100),
            const DataColumn2(label: Text('Ngày'), fixedWidth: 200),
            const DataColumn2(label: Text('Hành động'), fixedWidth: 100),
          ],
          source: BrandRows(),
        );
      },
    );
  }
}
