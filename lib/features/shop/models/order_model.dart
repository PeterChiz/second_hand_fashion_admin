import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../personalization/models/address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;
  OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String  paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.address,
    this.deliveryDate,
  });

  /// Lấy ngày được định dạng
  String get formattedOrderDate =>
      SHFHelperFunctions.getFormattedDate(orderDate);

  /// Lấy ngày giao hàng được định dạng
  String get formattedDeliveryDate => deliveryDate != null
      ? SHFHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  /// Lấy văn bản trạng thái đơn hàng
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Đã giao hàng'
      : status == OrderStatus.shipped
          ? 'Đang giao hàng'
          : 'Đang xử lý';

  /// Hàm tĩnh để tạo một mô hình đơn hàng trống.
  static OrderModel empty() => OrderModel(
      id: '',
      items: [],
      orderDate: DateTime.now(),
      status: OrderStatus.pending,
      totalAmount: 0); // Default createdAt to current time

  /// Chuyển đổi đối tượng thành cấu trúc Json để lưu trữ dữ liệu trong Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      // Enum to string
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      // Convert AddressModel to map
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
      // Convert CartItemModel to map
    };
  }

  /// Ánh xạ dữ liệu từ tài liệu snapshot từ Firebase thành OrderModel
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      docId: snapshot.id,
      id: data['id'] as String,
      userId: data['userId'] as String,
      status:
          OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}
