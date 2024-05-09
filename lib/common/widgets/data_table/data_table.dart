// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/sizes.dart';
//
// class SHFDataTable extends StatelessWidget {
//   const SHFDataTable({super.key,
//     required this.columns,
//     required this.rows,
//   });
//
//   /// List of columns for the data table
//   final List<DataColumn> columns;
//
//   /// List of rows for the data table
//   final List<DataRow> rows;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // Đặt chiều cao của bảng dữ liệu là 80% chiều cao của màn hình
//       height: MediaQuery.of(context).size.height * 0.8,
//       child: DataTable2(
//         // Gán các cột đã cung cấp cho bảng dữ liệu
//         columns: columns,
//         // Gán các hàng đã cung cấp cho bảng dữ liệu
//         rows: rows,
//         // Đặt chiều rộng tối thiểu của bảng dữ liệu
//         minWidth: 600,
//         // Đặt khoảng cách giữa các cột
//         columnSpacing: 12,
//         // Đặt lề ngang của bảng dữ liệu
//         horizontalMargin: 12,
//         // Đặt màu của hàng tiêu đề
//         headingRowColor: MaterialStateProperty.resolveWith((states) => SHFColors.primary),
//         // Đặt trang trí cho bảng dữ liệu
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(SHFSizes.borderRadiusMd)),
//         ),
//         // Đặt trang trí cho hàng tiêu đề của bảng dữ liệu
//         headingRowDecoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(SHFSizes.borderRadiusMd), topRight: Radius.circular(SHFSizes.borderRadiusMd)),
//         ),
//       ),
//     );
//   }
// }
