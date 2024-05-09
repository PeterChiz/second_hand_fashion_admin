import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/category/category_controller.dart';
import 'table_source.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(
          () {
        // Các danh mục & Các hàng đã chọn được ẩn => Chỉ để cập nhật giao diện => Obx => [Các hàng sản phẩm]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        // Bảng
        return SHFPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: const Text('Danh mục'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Danh mục cha')),
            const DataColumn2(label: Text('Nổi bật')),
            const DataColumn2(label: Text('Ngày')),
            const DataColumn2(label: Text('Hành động'), fixedWidth: 100),
          ],
          source: CategoryRows(),
        );
      },
    );
  }
}
