import 'package:flutter/material.dart';

/// Các hàm trợ giúp cho các hoạt động liên quan đến đám mây.
class SHFCloudHelperFunctions {


  /// Hàm trợ giúp để kiểm tra trạng thái của nhiều bản ghi (danh sách) cơ sở dữ liệu.
  ///
  /// Trả về một Widget dựa trên trạng thái của snapshot.
  /// Nếu dữ liệu vẫn đang tải, nó trả về CircularProgressIndicator.
  /// Nếu không tìm thấy dữ liệu, nó trả về một thông báo "Không tìm thấy dữ liệu" chung hoặc widget nothingFoundWidget tùy chỉnh nếu được cung cấp.
  /// Nếu có lỗi xảy ra, nó trả về một thông báo lỗi chung.
  /// Nếu không, nó trả về null.
  static Widget? checkMultiRecordState<SHF>(
      {required AsyncSnapshot<List<SHF>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('Không tìm thấy dữ liệu!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Đã xảy ra lỗi.'));
    }

    return null;
  }
}
