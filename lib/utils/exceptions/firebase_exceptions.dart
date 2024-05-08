/// Lớp ngoại lệ tùy chỉnh để xử lý các lỗi liên quan đến Firebase khác nhau.
class SHFFirebaseException implements Exception {
  /// Mã lỗi liên quan đến ngoại lệ.
  final String code;

  /// Constructor nhận một mã lỗi.
  SHFFirebaseException(this.code);

  /// Lấy thông điệp lỗi tương ứng dựa trên mã lỗi.
  String get message {
    switch (code) {
      case 'unknown':
        return 'Đã xảy ra một lỗi Firebase không xác định. Vui lòng thử lại.';
      case 'invalid-custom-token':
        return 'Định dạng mã thông tự tạo không đúng. Vui lòng kiểm tra mã thông tự tạo của bạn.';
      case 'custom-token-mismatch':
        return 'Mã thông tự tạo tương ứng với một khán giả khác.';
      case 'user-disabled':
        return 'Tài khoản người dùng đã bị vô hiệu hóa.';
      case 'user-not-found':
        return 'Không tìm thấy người dùng nào cho email hoặc UID đã cho.';
      case 'invalid-email':
        return 'Địa chỉ email được cung cấp không hợp lệ. Vui lòng nhập một email hợp lệ.';
      case 'email-already-in-use':
        return 'Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác.';
      case 'wrong-password':
        return 'Mật khẩu không chính xác. Vui lòng kiểm tra mật khẩu của bạn và thử lại.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn một mật khẩu mạnh hơn.';
      case 'provider-already-linked':
        return 'Tài khoản đã được liên kết với một nhà cung cấp khác.';
      case 'operation-not-allowed':
        return 'Thao tác này không được phép. Liên hệ hỗ trợ để được trợ giúp.';
      case 'invalid-credential':
        return 'Thông tin đăng nhập được cung cấp không đúng cách hoặc đã hết hạn.';
      case 'invalid-verification-code':
        return 'Mã xác minh không hợp lệ. Vui lòng nhập một mã hợp lệ.';
      case 'invalid-verification-id':
        return 'ID xác minh không hợp lệ. Vui lòng yêu cầu một mã xác minh mới.';
      case 'captcha-check-failed':
        return 'Phản hồi reCAPTCHA không hợp lệ. Vui lòng thử lại.';
      case 'app-not-authorized':
        return 'Ứng dụng không được ủy quyền để sử dụng Xác thực Firebase với khóa API được cung cấp.';
      case 'keychain-error':
        return 'Đã xảy ra lỗi bộ nhớ chính. Vui lòng kiểm tra keychain và thử lại.';
      case 'internal-error':
        return 'Đã xảy ra lỗi xác thực nội bộ. Vui lòng thử lại sau.';
      case 'invalid-app-credential':
        return 'Thông tin đăng nhập ứng dụng không hợp lệ. Vui lòng cung cấp một thông tin đăng nhập ứng dụng hợp lệ.';
      case 'user-mismatch':
        return 'Thông tin đăng nhập cung cấp không tương ứng với người dùng đã đăng nhập trước đó.';
      case 'requires-recent-login':
        return 'Thao tác này nhạy cảm và yêu cầu xác thực gần đây. Vui lòng đăng nhập lại.';
      case 'quota-exceeded':
        return 'Đã vượt quá hạn ngạch. Vui lòng thử lại sau.';
      case 'account-exists-with-different-credential':
        return 'Một tài khoản đã tồn tại với cùng một email nhưng thông tin đăng nhập khác nhau.';
      case 'missing-iframe-start':
        return 'Mẫu email thiếu thẻ bắt đầu iframe.';
      case 'missing-iframe-end':
        return 'Mẫu email thiếu thẻ kết thúc iframe.';
      case 'missing-iframe-src':
        return 'Mẫu email thiếu thuộc tính src của iframe.';
      case 'auth-domain-config-required':
        return 'Cấu hình authDomain được yêu cầu cho liên kết xác minh mã hành động.';
      case 'missing-app-credential':
        return 'Thông tin đăng nhập ứng dụng đã mất. Vui lòng cung cấp thông tin đăng nhập ứng dụng hợp lệ.';
      case 'session-cookie-expired':
        return 'Cookie phiên Firebase đã hết hạn. Vui lòng đăng nhập lại.';
      case 'uid-already-exists':
        return 'ID người dùng đã được sử dụng bởi người dùng khác.';
      case 'web-storage-unsupported':
        return 'Lưu trữ Web không được hỗ trợ hoặc đã bị vô hiệu hóa.';
      case 'app-deleted':
        return 'Phiên bản này của FirebaseApp đã bị xóa.';
      case 'user-token-mismatch':
        return 'Token của người dùng cung cấp không khớp với ID người dùng đã xác thực.';
      case 'invalid-message-payload':
        return 'Dữ liệu cơ bản của thông báo xác minh mẫu email không hợp lệ.';
      case 'invalid-sender':
        return 'Người gửi mẫu email không hợp lệ. Vui lòng xác minh email của người gửi.';
      case 'invalid-recipient-email':
        return 'Địa chỉ email người nhận không hợp lệ. Vui lòng cung cấp một địa chỉ email hợp lệ.';
      case 'missing-action-code':
        return 'Mã hành động bị thiếu. Vui lòng cung cấp một mã hành động hợp lệ.';
      case 'user-token-expired':
        return 'Token của người dùng đã hết hạn và yêu cầu xác thực. Vui lòng đăng nhập lại.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Thông tin đăng nhập không hợp lệ.';
      case 'expired-action-code':
        return 'Mã hành động đã hết hạn. Vui lòng yêu cầu một mã hành động mới.';
      case 'invalid-action-code':
        return 'Mã hành động không hợp lệ. Vui lòng kiểm tra mã và thử lại.';
      case 'credential-already-in-use':
        return 'Thông tin đăng nhập này đã được liên kết với một tài khoản người dùng khác.';
      default:
        return 'Đã xảy ra một lỗi Firebase không mong đợi. Vui lòng thử lại.';
    }
  }
}
