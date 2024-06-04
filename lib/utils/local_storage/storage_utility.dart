import 'package:get_storage/get_storage.dart';

class SHFLocalStorage {
  late final GetStorage _storage;

  // Thể hiện Singleton
  static SHFLocalStorage? _instance;

  SHFLocalStorage._internal();

  /// Tạo một hàm tạo có tên để lấy một thể hiện với một tên bucket cụ thể
  factory SHFLocalStorage.instance() {
    _instance ??= SHFLocalStorage._internal();
    return _instance!;
  }


  /// Phương thức khởi tạo không đồng bộ
  static Future<void> init(String bucketName) async {
    // Rất quan trọng khi  muốn sử dụng Bucket's
    await GetStorage.init(bucketName);
    _instance = SHFLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  /// Phương thức chung để lưu dữ liệu
  Future<void> writeData<SHF>(String key, SHF value) async {
    await _storage.write(key, value);
  }

  /// Phương thức chung để đọc dữ liệu
  SHF? readData<SHF>(String key) {
    return _storage.read<SHF>(key);
  }

  /// Phương thức chung để xóa dữ liệu
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Xóa tất cả dữ liệu trong bộ nhớ
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
