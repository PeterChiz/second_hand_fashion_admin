/// Lớp ngoại lệ tùy chỉnh để xử lý các lỗi liên quan đến định dạng khác nhau.
class SHFFormatException implements Exception {
  /// Thông điệp lỗi liên quan.
  final String message;

  /// Hàm tạo mặc định với một thông điệp lỗi chung.
  const SHFFormatException([this.message = 'Đã xảy ra một lỗi định dạng không mong đợi. Vui lòng kiểm tra đầu vào của bạn.']);

  /// Tạo một ngoại lệ định dạng từ một thông điệp lỗi cụ thể.
  factory SHFFormatException.fromMessage(String message) {
    return SHFFormatException(message);
  }

  /// Lấy thông điệp lỗi tương ứng.
  String get formattedMessage => message;

  /// Tạo một ngoại lệ định dạng từ một mã lỗi cụ thể.
  factory SHFFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const SHFFormatException('Định dạng địa chỉ email không hợp lệ. Vui lòng nhập một email hợp lệ.');
      case 'invalid-phone-number-format':
        return const SHFFormatException('Định dạng số điện thoại được cung cấp không hợp lệ. Vui lòng nhập một số hợp lệ.');
      case 'invalid-date-format':
        return const SHFFormatException('Định dạng ngày không hợp lệ. Vui lòng nhập một ngày hợp lệ.');
      case 'invalid-url-format':
        return const SHFFormatException('Định dạng URL không hợp lệ. Vui lòng nhập một URL hợp lệ.');
      case 'invalid-credit-card-format':
        return const SHFFormatException('Định dạng thẻ tín dụng không hợp lệ. Vui lòng nhập một số thẻ tín dụng hợp lệ.');
      case 'invalid-numeric-format':
        return const SHFFormatException('Đầu vào phải có định dạng số hợp lệ.');
      default:
        return const SHFFormatException();
    }
  }
}