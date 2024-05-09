import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/routes.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Lấy dữ liệu người dùng đã xác thực
  User? get authUser => _auth.currentUser;

  // Kiểm tra người dùng đã xác thực hay chưa
  bool get isAuthenticated => _auth.currentUser != null;

  // Được gọi từ main.dart khi ứng dụng được khởi chạy
  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
    // Chuyển hướng đến màn hình tương ứng
    screenRedirect();
  }

  // Hàm xác định màn hình liên quan và chuyển hướng tương ứng.
  void screenRedirect() async {
    final user = _auth.currentUser;

    // Nếu người dùng đã đăng nhập
    if (user != null) {
      // Chuyển đến Trang chủ
      Get.offAllNamed(SHFRoutes.dashboard);
    } else {
      Get.offAllNamed(SHFRoutes.login);
    }
  }

  // Đăng nhập bằng Email & Password

  // ĐĂNG NHẬP
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // ĐĂNG KÝ
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // ĐĂNG KÝ NGƯỜI DÙNG BỞI QUẢN TRỊ VIÊN
  Future<UserCredential> registerUserByAdmin(String email, String password) async {
    try {
      FirebaseApp app = await Firebase.initializeApp(name: 'RegisterUser', options: Firebase.app().options);
      UserCredential userCredential =
      await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(email: email, password: password);

      await app.delete();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // XÁC THỰC EMAIL
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // QUÊN MẬT KHẨU
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // XÁC THỰC LẠI NGƯỜI DÙNG
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Tạo một thông tin xác thực
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // Xác thực lại
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // Đăng xuất Người dùng
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(SHFRoutes.login);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) print(e);
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      if (kDebugMode) print('Format Exception Caught');
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }

  // XÓA TÀI KHOẢN - Xóa Tài khoản xác thực và Firestore.
  Future<void> deleteAccount() async {
    try {
      // await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có điều gì đó đã sai. Vui lòng thử lại';
    }
  }
}
