import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/brand_category_model.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  // Singleton instance of the BrandRepository
  static BrandRepository get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lấy tất cả các thương hiệu từ bộ sưu tập 'Brands'
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi! Vui lòng thử lại.';
    }
  }

  // Lấy tất cả các danh mục thương hiệu từ bộ sưu tập 'BrandCategory'
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final brandCategoryQuery = await _db.collection('BrandCategory').get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi! Vui lòng thử lại.';
    }
  }

  // Lấy các danh mục thương hiệu cụ thể cho một ID thương hiệu nhất định
  Future<List<BrandCategoryModel>> getSpecificBrandCategories(
      String brandId) async {
    try {
      final brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi! Vui lòng thử lại.';
    }
  }

  // Tạo một tài liệu thương hiệu mới trong bộ sưu tập 'Brands'
  Future<String> createBrand(BrandModel brand) async {
    try {
      final result = await _db.collection("Brands").add(brand.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  // Tạo một tài liệu danh mục thương hiệu mới trong bộ sưu tập 'BrandCategory'
  Future<String> createBrandCategory(BrandCategoryModel brandCategory) async {
    try {
      final result =
          await _db.collection("BrandCategory").add(brandCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  // Cập nhật một tài liệu thương hiệu hiện có trong bộ sưu tập 'Brands'
  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection("Brands").doc(brand.id).update(brand.toJson());
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  // Xóa một tài liệu thương hiệu hiện có và các danh mục thương hiệu liên quan của nó
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection("Brands").doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception("Thương hiệu không tồn tại");
        }

        final brandCategoriesSnapshot = await _db
            .collection('BrandCategory')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = brandCategoriesSnapshot.docs
            .map((e) => BrandCategoryModel.fromSnapshot(e));

        if (brandCategories.isNotEmpty) {
          for (var brandCategory in brandCategories) {
            transaction
                .delete(_db.collection('BrandCategory').doc(brandCategory.id));
          }
        }

        transaction.delete(brandRef);
      });
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  // Xóa một tài liệu danh mục thương hiệu trong bộ sưu tập 'BrandCategory'
  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try {
      await _db.collection("BrandCategory").doc(brandCategoryId).delete();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }
}
