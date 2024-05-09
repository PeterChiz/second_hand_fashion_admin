import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Lớp dịch vụ cho các hoạt động liên quan đến Firebase Storage
class SHFFirebaseStorageService extends GetxController {
  static SHFFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  /// Tải dữ liệu hình ảnh từ tài nguyên đến Firebase Storage
  /// Trả về một Uint8List chứa dữ liệu hình ảnh.
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      // Xử lý ngoại lệ một cách lịch sự
      throw 'Lỗi khi tải dữ liệu hình ảnh: $e';
    }
  }

  /// Tải dữ liệu hình ảnh lên Firebase Storage
  /// Trả về URL tải xuống của hình ảnh đã tải lên.
  Future<String> uploadImageData(String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // Xử lý ngoại lệ một cách lịch sự
      if (e is FirebaseException) {
        throw 'Ngoại lệ Firebase: ${e.message}';
      } else if (e is SocketException) {
        throw 'Lỗi Mạng: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Ngoại lệ Nền tảng: ${e.message}';
      } else {
        throw 'Đã xảy ra lỗi! Vui lòng thử lại.';
      }
    }
  }

  /// Tải tệp hình ảnh lên Firebase Storage
  /// Trả về URL tải xuống của hình ảnh đã tải lên.
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // Xử lý ngoại lệ một cách lịch sự
      if (e is FirebaseException) {
        throw 'Ngoại lệ Firebase: ${e.message}';
      } else if (e is SocketException) {
        throw 'Lỗi Mạng: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Ngoại lệ Nền tảng: ${e.message}';
      } else {
        throw 'Đã xảy ra lỗi! Vui lòng thử lại.';
      }
    }
  }
}
