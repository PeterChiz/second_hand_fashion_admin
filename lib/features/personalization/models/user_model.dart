import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/formatters/formatter.dart';
import '../../../utils/constants/enums.dart';
import '../../shop/models/order_model.dart';
import 'address_model.dart';

/// Lớp mô hình đại diện cho dữ liệu người dùng.
class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses;

  /// Constructor for UserModel.
  UserModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
  });

  /// Các phương thức trợ giúp
  String get fullName => '$lastName $firstName';
  String get formattedPhoneNo => SHFFormatter.formatPhoneNumber(phoneNumber);
  String get formattedDate => SHFFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => SHFFormatter.formatDate(updatedAt);

  /// Phương thức tĩnh để tạo một mô hình người dùng trống.
  static UserModel empty() => UserModel(email: ''); // Thời gian tạo mặc định là thời gian hiện tại

  /// Chuyển đổi mô hình sang cấu trúc JSON để lưu trữ dữ liệu trong Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  /// Phương thức factory để tạo một UserModel từ một snapshot của Firebase document.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber: data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture') ? data['ProfilePicture'] ?? '' : '',
        role: data.containsKey('Role') ? (data['Role'] ?? AppRole.user) == AppRole.admin.name.toString() ? AppRole.admin : AppRole.user : AppRole.user,
        createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
