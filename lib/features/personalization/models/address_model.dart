import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => SHFFormatter.formatPhoneNumber(phoneNumber);

  // Tạo một AddressModel trống.
  static AddressModel empty() => AddressModel(id: '', name: '', phoneNumber: '', street: '', city: '');

  // Chuyển đổi sang dạng Json.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  // Tạo một AddressModel từ Map.
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp?)?.toDate(),
    );
  }

  // Tạo một AddressModel từ DocumentSnapshot.
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp?)?.toDate(),
    );
  }

  @override
  String toString() {
    return '$street, $city';
  }
}
