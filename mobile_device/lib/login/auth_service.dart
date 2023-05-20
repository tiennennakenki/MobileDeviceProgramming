import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đăng nhập với email và password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Đăng ký với email và password
  Future<dynamic> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Đăng ký thành công, trả về thông tin người dùng hoặc null (tuỳ thuộc vào yêu cầu của bạn)
      return result.user;
    } catch (error) {
      // Xử lý lỗi đăng ký
      print('Lỗi đăng ký: $error');
      return null;
    }
  }

  // Đăng xuất
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}