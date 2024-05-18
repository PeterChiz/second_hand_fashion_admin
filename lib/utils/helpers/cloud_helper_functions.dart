import 'dart:html' as html;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Các hàm trợ giúp cho các hoạt động liên quan đến đám mây.
class SHFCloudHelperFunctions {
  /// Hàm trợ giúp để kiểm tra trạng thái của một bản ghi cơ sở dữ liệu.
  ///
  /// Trả về một Widget dựa trên trạng thái của snapshot.
  /// Nếu dữ liệu vẫn đang tải, nó trả về CircularProgressIndicator.
  /// Nếu không tìm thấy dữ liệu, nó trả về một thông báo "Không tìm thấy dữ liệu".
  /// Nếu có lỗi xảy ra, nó trả về một thông báo lỗi chung.
  /// Nếu không, nó trả về null.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('Không tìm thấy dữ liệu!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Đã xảy ra lỗi.'));
    }

    return null;
  }

  /// Hàm trợ giúp để kiểm tra trạng thái của nhiều bản ghi (danh sách) cơ sở dữ liệu.
  ///
  /// Trả về một Widget dựa trên trạng thái của snapshot.
  /// Nếu dữ liệu vẫn đang tải, nó trả về CircularProgressIndicator.
  /// Nếu không tìm thấy dữ liệu, nó trả về một thông báo "Không tìm thấy dữ liệu" chung hoặc widget nothingFoundWidget tùy chỉnh nếu được cung cấp.
  /// Nếu có lỗi xảy ra, nó trả về một thông báo lỗi chung.
  /// Nếu không, nó trả về null.
  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
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

  /// Tạo một tham chiếu với đường dẫn và tên tệp ban đầu và truy xuất URL tải xuống.
  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi.';
    }
  }

  /// Truy xuất URL tải xuống từ một URI lưu trữ đã cho.
  static Future<String> getURLFromURI(String url) async {
    try {
      if (url.isEmpty) return '';
      final ref = FirebaseStorage.instance.refFromURL(url);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi.';
    }
  }

  /// Tải lên bất kỳ hình ảnh nào sử dụng tệp
  static Future<String> uploadImageFile(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(imageName);
      await ref.putBlob(file);
      final String downloadURL = await ref.getDownloadURL();

      // Trả về URL tải xuống
      return downloadURL;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> deleteFileFromStorage(String downloadUrl) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(downloadUrl);
      await ref.delete();
      print('Đã xóa tệp thành công.');
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        print('Tệp không tồn tại trong Firebase Storage.');
      } else {
        throw e.message!;
      }
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
