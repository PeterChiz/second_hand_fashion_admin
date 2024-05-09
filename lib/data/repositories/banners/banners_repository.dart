import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  // Get instance of BannerRepository using Get.find()
  static BannerRepository get instance => Get.find();

  // Firebase Firestore instance
  final _db = FirebaseFirestore.instance;

  // Lấy tất cả các banner từ Firestore
  Future<List<BannerModel>> getAllBanners() async {
    try {
      // Truy vấn bộ sưu tập Firestore để lấy tất cả các banner
      final snapshot = await _db.collection("Banners").get();
      // Chuyển đổi snapshot tài liệu Firestore thành đối tượng BannerModel
      final result = snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      // Xử lý các ngoại lệ Firebase
      throw e.message!;
    } on SocketException catch (e) {
      // Xử lý các ngoại lệ Socket
      throw e.message;
    } on PlatformException catch (e) {
      // Xử lý các ngoại lệ Platform
      throw e.message!;
    } catch (e) {
      // Bắt các ngoại lệ khác
      throw 'Có lỗi xảy ra! Vui lòng thử lại.';
    }
  }

  // Tạo một banner mới trong Firestore
  Future<String> createBanner(BannerModel banner) async {
    try {
      // Thêm banner vào bộ sưu tập "Banners" trong Firestore
      final result = await _db.collection("Banners").add(banner.toJson());
      // Trả về ID của banner mới được tạo
      return result.id;
    } on FirebaseException catch (e) {
      // Xử lý các ngoại lệ Firebase
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Xử lý các ngoại lệ Format
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      // Xử lý các ngoại lệ Platform
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      // Bắt các ngoại lệ khác
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // Cập nhật một banner đã tồn tại trong Firestore
  Future<void> updateBanner(BannerModel banner) async {
    try {
      // Cập nhật banner với ID đã chỉ định trong Firestore
      await _db.collection("Banners").doc(banner.id).update(banner.toJson());
    } on FirebaseException catch (e) {
      // Xử lý các ngoại lệ Firebase
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Xử lý các ngoại lệ Format
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      // Xử lý các ngoại lệ Platform
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      // Bắt các ngoại lệ khác
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // Xóa một banner khỏi Firestore
  Future<void> deleteBanner(String bannerId) async {
    try {
      // Xóa banner có ID đã chỉ định khỏi Firestore
      await _db.collection("Banners").doc(bannerId).delete();
    } on FirebaseException catch (e) {
      // Xử lý các ngoại lệ Firebase
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Xử lý các ngoại lệ Format
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      // Xử lý các ngoại lệ Platform
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      // Bắt các ngoại lệ khác
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }
}
