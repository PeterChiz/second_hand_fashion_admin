/// Lớp ngoại lệ để xử lý các lỗi khác nhau.
class SHFExceptions implements Exception {
  /// Thông điệp lỗi liên quan.
  final String message;

  /// Constructor mặc định với một thông điệp lỗi chung.
  const SHFExceptions([this.message = 'Đã xảy ra một lỗi không mong đợi. Vui lòng thử lại.']);

  /// Tạo một ngoại lệ xác thực từ mã ngoại lệ xác thực Firebase.
  factory SHFExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const SHFExceptions('Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác.');
      case 'invalid-email':
        return const SHFExceptions('Địa chỉ email được cung cấp không hợp lệ. Vui lòng nhập một email hợp lệ.');
      case 'weak-password':
        return const SHFExceptions('Mật khẩu quá yếu. Vui lòng chọn một mật khẩu mạnh hơn.');
      case 'user-disabled':
        return const SHFExceptions('Tài khoản người dùng này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ để được trợ giúp.');
      case 'user-not-found':
        return const SHFExceptions('Thông tin đăng nhập không hợp lệ. Người dùng không được tìm thấy.');
      case 'wrong-password':
        return const SHFExceptions('Mật khẩu không chính xác. Vui lòng kiểm tra mật khẩu của bạn và thử lại.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const SHFExceptions('Thông tin đăng nhập không hợp lệ. Vui lòng kiểm tra lại thông tin của bạn.');
      case 'too-many-requests':
        return const SHFExceptions('Quá nhiều yêu cầu. Vui lòng thử lại sau.');
      case 'invalid-argument':
        return const SHFExceptions('Đối số không hợp lệ được cung cấp cho phương thức xác thực.');
      case 'invalid-password':
        return const SHFExceptions('Mật khẩu không chính xác. Vui lòng thử lại.');
      case 'invalid-phone-number':
        return const SHFExceptions('Số điện thoại được cung cấp không hợp lệ.');
      case 'operation-not-allowed':
        return const SHFExceptions('Nhà cung cấp đăng nhập bị vô hiệu hóa cho dự án Firebase của bạn.');
      case 'session-cookie-expired':
        return const SHFExceptions('Cookie phiên Firebase đã hết hạn. Vui lòng đăng nhập lại.');
      case 'uid-already-exists':
        return const SHFExceptions('ID người dùng đã được sử dụng bởi người dùng khác.');
      case 'sign_in_failed':
        return const SHFExceptions('Đăng nhập thất bại. Vui lòng thử lại.');
      case 'network-request-failed':
        return const SHFExceptions('Yêu cầu mạng thất bại. Vui lòng kiểm tra kết nối internet của bạn.');
      case 'internal-error':
        return const SHFExceptions('Lỗi nội bộ. Vui lòng thử lại sau.');
      case 'invalid-verification-code':
        return const SHFExceptions('Mã xác minh không hợp lệ. Vui lòng nhập một mã hợp lệ.');
      case 'invalid-verification-id':
        return const SHFExceptions('ID xác minh không hợp lệ. Vui lòng yêu cầu một mã xác minh mới.');
      case 'quota-exceeded':
        return const SHFExceptions('Đã vượt quá hạn ngạch. Vui lòng thử lại sau.');
      default:
        return const SHFExceptions();
    }
  }
}