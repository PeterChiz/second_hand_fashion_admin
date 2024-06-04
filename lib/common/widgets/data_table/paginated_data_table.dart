import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../loaders/animation_loader.dart';

/// Widget PaginatedDataTable tùy chỉnh với các tính năng bổ sung
class SHFPaginatedDataTable extends StatelessWidget {
  const SHFPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = SHFSizes.xl * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  /// Cho biết liệu có nên sắp xếp DataTable theo thứ tự tăng dần hay giảm dần.
  final bool sortAscending;

  /// Chỉ mục của cột để sắp xếp theo.
  final int? sortColumnIndex;

  /// Số hàng được hiển thị mỗi trang.
  final int rowsPerPage;

  /// Nguồn dữ liệu cho DataTable.
  final DataTableSource source;

  /// Danh sách các cột cho DataTable.
  final List<DataColumn> columns;

  /// Hàm gọi lại để xử lý thay đổi trang.
  final Function(int)? onPageChanged;

  /// Chiều cao của mỗi hàng dữ liệu trong DataTable.
  final double dataRowHeight;

  /// Chiều cao của toàn bộ DataTable.
  final double tableHeight;

  /// Chiều rộng tối thiểu của toàn bộ DataTable.
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Đặt chiều cao động của PaginatedDataTable
      height: tableHeight,
      child: Theme(
        // Sử dụng để đặt màu nền
        data: Theme.of(context).copyWith(
            cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
        child: PaginatedDataTable2(
          source: source,
          columns: columns,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          showFirstLastButtons: true,
          showCheckboxColumn: false,
          sortAscending: sortAscending,
          onPageChanged: onPageChanged,
          dataRowHeight: dataRowHeight,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},
          sortColumnIndex: sortColumnIndex,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateProperty.resolveWith(
              (states) => SHFColors.primaryBackground),
          empty: SHFAnimationLoaderWidget(
              animation: SHFImages.packageAnimation,
              text: 'Không có gì được tìm thấy',
              height: 200,
              width: 200),
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SHFSizes.borderRadiusMd),
              topRight: Radius.circular(SHFSizes.borderRadiusMd),
            ),
          ),
          sortArrowBuilder: (bool ascending, bool sorted) {
            if (sorted) {
              return Icon(ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                  size: SHFSizes.iconSm);
            } else {
              return const Icon(Iconsax.arrow_3, size: SHFSizes.iconSm);
            }
          },
        ),
      ),
    );
  }
}
