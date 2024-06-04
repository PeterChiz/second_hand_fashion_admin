import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../popups/loaders.dart';

/// Quản lý trạng thái kết nối mạng và cung cấp các phương thức để kiểm tra và xử lý thay đổi kết nối.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;

  /// Khởi tạo quản lý mạng và thiết lập một luồng để liên tục kiểm tra trạng thái kết nối.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Cập nhật trạng thái kết nối dựa trên thay đổi kết nối và hiển thị cửa sổ bật lên liên quan đến không có kết nối internet.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;
    if (result.contains(ConnectivityResult.none)) {
      SHFLoaders.customToast(message: 'Không có kết nối Internet');
    }
  }

  /// Kiểm tra trạng thái kết nối internet.
  /// Trả về `true` nếu đã kết nối, `false` nếu ngược lại.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.any((element) => element == ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Hủy hoặc đóng luồng kết nối đang hoạt động.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}

