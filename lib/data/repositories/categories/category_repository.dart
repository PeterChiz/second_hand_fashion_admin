import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  //Bản Singleton của CategoryRepository
  static CategoryRepository get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lấy tất cả các danh mục từ bộ sưu tập 'Categories'
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // Tạo một tài liệu danh mục mới trong bộ sưu tập 'Categories'
  Future<String> createCategory(CategoryModel category) async {
    try {
      final data = await _db.collection("Categories").add(category.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // Cập nhật một tài liệu danh mục đã tồn tại trong bộ sưu tập 'Categories'
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _db.collection("Categories").doc(category.id).update(category.toJson());
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // Xóa một tài liệu danh mục đã tồn tại khỏi bộ sưu tập 'Categories'
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection("Categories").doc(categoryId).delete();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }
}
