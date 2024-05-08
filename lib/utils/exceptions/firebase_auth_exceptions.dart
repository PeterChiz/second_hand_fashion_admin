/// Lớp ngoại lệ tùy chỉnh để xử lý các lỗi liên quan đến xác thực Firebase khác nhau.
class SHFFirebaseAuthException implements Exception {
  /// Mã lỗi liên quan đến ngoại lệ.
  final String code;

  /// Constructor nhận một mã lỗi.
  SHFFirebaseAuthException(this.code);

  /// Lấy thông điệp lỗi tương ứng dựa trên mã lỗi.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác.';
      case 'invalid-email':
        return 'Địa chỉ email được cung cấp không hợp lệ. Vui lòng nhập một email hợp lệ.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn một mật khẩu mạnh hơn.';
      case 'user-disabled':
        return 'Tài khoản người dùng này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ để được trợ giúp.';
      case 'user-not-found':
        return 'Thông tin đăng nhập không hợp lệ. Người dùng không được tìm thấy.';
      case 'wrong-password':
        return 'Mật khẩu không chính xác. Vui lòng kiểm tra mật khẩu của bạn và thử lại.';
      case 'invalid-verification-code':
        return 'Mã xác minh không hợp lệ. Vui lòng nhập một mã hợp lệ.';
      case 'invalid-verification-id':
        return 'ID xác minh không hợp lệ. Vui lòng yêu cầu một mã xác minh mới.';
      case 'quota-exceeded':
        return 'Đã vượt quá hạn ngạch. Vui lòng thử lại sau.';
      case 'email-already-exists':
        return 'Địa chỉ email đã tồn tại. Vui lòng sử dụng một email khác.';
      case 'provider-already-linked':
        return 'Tài khoản đã được liên kết với một nhà cung cấp khác.';
      case 'requires-recent-login':
        return 'Thao tác này nhạy cảm và yêu cầu xác thực gần đây. Vui lòng đăng nhập lại.';
      case 'credential-already-in-use':
        return 'Thông tin đăng nhập này đã được liên kết với một tài khoản người dùng khác.';
      case 'user-mismatch':
        return 'Thông tin đăng nhập cung cấp không tương ứng với người dùng đã đăng nhập trước đó.';
      case 'account-exists-with-different-credential':
        return 'Một tài khoản đã tồn tại với cùng một email nhưng thông tin đăng nhập khác nhau.';
      case 'operation-not-allowed':
        return 'Thao tác này không được phép. Liên hệ hỗ trợ để được trợ giúp.';
      case 'expired-action-code':
        return 'Mã hành động đã hết hạn. Vui lòng yêu cầu một mã hành động mới.';
      case 'invalid-action-code':
        return 'Mã hành động không hợp lệ. Vui lòng kiểm tra mã và thử lại.';
      case 'missing-action-code':
        return 'Mã hành động bị thiếu. Vui lòng cung cấp một mã hành động hợp lệ.';
      case 'user-token-expired':
        return 'Token của người dùng đã hết hạn, và cần xác thực. Vui lòng đăng nhập lại.';
      case 'invalid-credential':
        return 'Thông tin đăng nhập được cung cấp không đúng cách hoặc đã hết hạn.';
      case 'user-token-revoked':
        return 'Token của người dùng đã bị thu hồi. Vui lòng đăng nhập lại.';
      case 'invalid-message-payload':
        return 'Dữ liệu cơ bản của thông báo xác minh mẫu email không hợp lệ.';
      case 'invalid-sender':
        return 'Người gửi mẫu email không hợp lệ. Vui lòng xác minh email của người gửi.';
      case 'invalid-recipient-email':
        return 'Địa chỉ email người nhận không hợp lệ. Vui lòng cung cấp một địa chỉ email hợp lệ.';
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
      case 'invalid-app-credential':
        return 'Thông tin đăng nhập ứng dụng không hợp lệ. Vui lòng cung cấp một thông tin đăng nhập ứng dụng hợp lệ.';
      case 'session-cookie-expired':
        return 'Cookie phiên Firebase đã hết hạn. Vui lòng đăng nhập lại.';
      case 'uid-already-exists':
        return 'ID người dùng đã được sử dụng bởi người dùng khác.';
      case 'invalid-cordova-configuration':
        return 'Cấu hình Cordova được cung cấp không hợp lệ.';
      case 'app-deleted':
        return 'Phiên bản này của FirebaseApp đã bị xóa.';
      case 'user-token-mismatch':
        return 'Token của người dùng đã cung cấp không tương ứng với ID người dùng đã xác thực.';
      case 'web-storage-unsupported':
        return 'Lưu trữ web không được hỗ trợ hoặc bị vô hiệu hóa.';
      case 'app-not-authorized':
        return 'Ứng dụng không được ủy quyền để sử dụng Xác thực Firebase với khóa API được cung cấp.';
      case 'keychain-error':
        return 'Đã xảy ra lỗi với keychain. Vui lòng kiểm tra keychain và thử lại.';
      case 'internal-error':
        return 'Đã xảy ra lỗi xác thực nội bộ. Vui lòng thử lại sau.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Thông tin đăng nhập không hợp lệ.';
      default:
        return 'Đã xảy ra một lỗi xác thực không mong đợi. Vui lòng thử lại.';
    }
  }
}