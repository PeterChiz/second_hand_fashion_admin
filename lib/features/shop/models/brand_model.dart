import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';
import 'category_model.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Not mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Lấy ngày được định dạng
  String get formattedDate => SHFFormatter.formatDate(createdAt);

  /// Lấy ngày được cập nhật được định dạng
  String get formattedUpdatedAtDate => SHFFormatter.formatDate(updatedAt);

  /// Chuyển đổi model thành cấu trúc Json để bạn có thể lưu trữ dữ liệu trong Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'CreatedAt': createdAt,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount ?? 0,
      'UpdatedAt': updatedAt ?? DateTime.now(),
    };
  }

  /// Ánh xạ dữ liệu dạng Json từ tài liệu snapshot từ Firebase thành UserModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
      createdAt: data.containsKey('CreatedAt') ? (data['CreatedAt'] as Timestamp).toDate() : null,
      updatedAt: data.containsKey('UpdatedAt') ? (data['UpdatedAt'] as Timestamp).toDate() : null,
    );
  }

  /// Ánh xạ dữ liệu dạng Json từ tài liệu snapshot từ Firebase thành UserModel
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Ánh xạ bản ghi JSON thành Model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: data['ProductsCount'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false,
        createdAt: data.containsKey('CreatedAt') ? (data['CreatedAt'] as Timestamp).toDate() : null,
        updatedAt: data.containsKey('UpdatedAt') ? (data['UpdatedAt'] as Timestamp).toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
