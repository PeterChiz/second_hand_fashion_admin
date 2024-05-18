import 'dart:html' as html;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/media/models/image_model.dart';
import '../../../utils/constants/enums.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Tải bất kì ảnh sử dụng file
  Future<ImageModel> uploadImageFileInStorage({required html.File file, required String path, required String imageName}) async {
    try {
      // Tham chiếu đến vị trí lưu trữ
      final Reference ref = _storage.ref('$path/$imageName');
      // Tải lên tệp
      await ref.putBlob(file);

      // Lấy URL tải xuống
      final String downloadURL = await ref.getDownloadURL();

      // Lấy dữ liệu siêu dữ liệu
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(metadata, path, imageName, downloadURL);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  /// Upload dữ liệu hình ảnh vào Firestore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance.collection("Images").add(image.toJson());
      return data.id;
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

  // Lấy hình ảnh từ Firestore dựa trên danh mục phương tiện và số lượng tải
  Future<List<ImageModel>> fetchImagesFromDatabase(MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Images")
          .where("mediaCategory", isEqualTo: mediaCategory.name.toString())
          .orderBy("createdAt", descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
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

  // Tải thêm hình ảnh từ Firestore dựa trên danh mục phương tiện, số lượng tải và ngày cuối cùng đã tải
  Future<List<ImageModel>> loadMoreImagesFromDatabase(MediaCategory mediaCategory, int loadCount, DateTime lastFetchedDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Images")
          .where("mediaCategory", isEqualTo: mediaCategory.name.toString())
          .orderBy("createdAt", descending: true)
          .startAfter([lastFetchedDate])
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  // Lấy tất cả hình ảnh từ Firebase Storage
  Future<List<ImageModel>> fetchAllImages() async {
    try {
      final ListResult result = await _storage.ref().listAll();
      final List<ImageModel> images = [];

      for (final Reference ref in result.items) {
        final String filename = ref.name;

        // Lấy URL tải xuống
        final String downloadURL = await ref.getDownloadURL();

        // Lấy dữ liệu siêu dữ liệu
        final FullMetadata metadata = await ref.getMetadata();

        images.add(ImageModel.fromFirebaseMetadata(metadata, '', filename, downloadURL));
      }

      return images;
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

  // Xóa tệp từ Firebase Storage và tài liệu tương ứng từ Firestore
  Future<void> deleteFileFromStorage(ImageModel image, String path) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(image.url);
      await ref.delete();
      await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();

      if (kDebugMode) print('Xóa thành công file');
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        if (kDebugMode) print('Tệp không tồn tại trong Firebase Storage.');
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
