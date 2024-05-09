import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/personalization/models/address_model.dart';
import '../authentication/authentication_repository.dart';

class AddressRepository extends GetxController {
  // Get instance of AddressRepository using Get.find()
  static AddressRepository get instance => Get.find();

  // Firebase Firestore instance
  final _db = FirebaseFirestore.instance;

  // Lấy địa chỉ người dùng từ Firestore dựa trên userId
  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      // Truy vấn bộ sưu tập Firestore để lấy địa chỉ người dùng
      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      // Chuyển đổi các snapshot tài liệu Firestore thành các đối tượng AddressModel
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      // Ném một lỗi nếu việc lấy địa chỉ thất bại
      throw 'Có lỗi xảy ra khi lấy Thông tin Địa chỉ. Thử lại sau';
    }
  }

  // Cập nhật trường "SelectedAddress" cho một địa chỉ cụ thể
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      // Lấy ID người dùng hiện tại
      final userId = AuthenticationRepository.instance.authUser!.uid;
      // Cập nhật trường được chọn cho địa chỉ cụ thể trong Firestore
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    } catch (e) {
      // Ném một lỗi nếu việc cập nhật việc chọn địa chỉ thất bại
      throw 'Không thể cập nhật việc chọn địa chỉ của bạn. Thử lại sau';
    }
  }

  // Thêm một địa chỉ mới vào Firestore
  Future<String> addAddress(AddressModel address) async {
    try {
      // Lấy ID người dùng hiện tại
      final userId = AuthenticationRepository.instance.authUser!.uid;
      // Thêm địa chỉ vào bộ sưu tập của người dùng trong Firestore
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      // Trả về ID của địa chỉ mới được thêm
      return currentAddress.id;
    } catch (e) {
      // Ném một lỗi nếu việc thêm địa chỉ thất bại
      throw 'Có lỗi xảy ra khi lưu Thông tin Địa chỉ. Thử lại sau';
    }
  }
}
