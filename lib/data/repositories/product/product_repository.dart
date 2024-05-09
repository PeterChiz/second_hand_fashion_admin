import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/product_category_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


/// Repository quản lý dữ liệu và hoạt động liên quan đến sản phẩm.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance để tương tác với cơ sở dữ liệu.
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- HÀM ---------------------------------*/

  /// Tạo sản phẩm.
  Future<String> createProduct(ProductModel product) async {
    try {
      final result = await _db.collection('Products').add(product.toJson());
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

  /// Tạo danh mục sản phẩm mới
  Future<String> createProductCategory(ProductCategoryModel productCategory) async {
    try {
      final result = await _db.collection("ProductCategory").add(productCategory.toJson());
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

  /// Cập nhật sản phẩm.
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
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

  /// Cập nhật Instance Sản phẩm
  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try {
      await _db.collection('Products').doc(id).update(data);
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

  /// Lấy các sản phẩm nổi bật giới hạn.
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  /// Lấy danh mục sản phẩm giới hạn.
  Future<List<ProductCategoryModel>> getProductCategories(String productId) async {
    try {
      final snapshot = await _db.collection('ProductCategory').where('productId', isEqualTo: productId).get();
      return snapshot.docs.map((querySnapshot) => ProductCategoryModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  /// Xóa danh mục sản phẩm
  Future<void> removeProductCategory(String productId, String categoryId) async {
    try {
      final result =
      await _db.collection("ProductCategory").where('productId', isEqualTo: productId).where('categoryId', isEqualTo: categoryId).get();

      for (final doc in result.docs) {
        await doc.reference.delete();
      }
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

  /// Xóa sản phẩm
  Future<void> deleteProduct(ProductModel product) async {
    try {
      // Xóa tất cả dữ liệu cùng lúc từ Firebase Firestore
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection("Products").doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception("Không tìm thấy sản phẩm");
        }

        // Lấy các danh mục sản phẩm
        final productCategoriesSnapshot = await _db.collection('ProductCategory').where('productId', isEqualTo: product.id).get();
        final productCategories = productCategoriesSnapshot.docs.map((e) => ProductCategoryModel.fromSnapshot(e));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(_db.collection('ProductCategory').doc(productCategory.id));
          }
        }

        transaction.delete(productRef);
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
}
