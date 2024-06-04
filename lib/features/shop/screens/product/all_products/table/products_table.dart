import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/product/product_controller.dart';
import 'table_source.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(
      () {
        // Các đơn hàng & Rows được chọn được ẩn => Cập nhật UI => Obx => [ProductRows]
        Visibility(
            visible: false,
            child: Text(controller.filteredItems.length.toString()));
        Visibility(
            visible: false,
            child: Text(controller.selectedRows.length.toString()));

        // Table
        return SHFPaginatedDataTable(
          minWidth: 1000,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
              label: const Text('Sản phẩm'),
              fixedWidth: !SHFDeviceUtils.isDesktopScreen(context) ? 300 : 400,
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: const Text('Hàng tồn'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByStock(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Thương hiệu')),
            DataColumn2(
              label: const Text('Giá'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByPrice(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Ngày')),
            const DataColumn2(label: Text('Hành động'), fixedWidth: 100),
          ],
          source: ProductsRows(),
        );
      },
    );
  }
}
