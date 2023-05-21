import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_device/register/page_register.dart';
import '../product/general_interface.dart';
import 'laptop_connect.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  final bool isLoggedIn;
  const LoginPage({super.key, required this.isLoggedIn});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool isLoggedIn = false; // Ban đầu, chưa đăng nhập

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 150,
              ),
              SizedBox(height: 40.0),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (val) =>
                      val!.isEmpty ? 'Vui lòng nhập email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Mật khẩu',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (val) =>
                      val!.length < 6 ? 'Mật khẩu phải có ít nhất 6 ký tự' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                      email,
                      password,
                    );
                    if (result == null) {
                      setState(() =>
                      error = 'Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin đăng nhập.');
                    } else {
                      setState(() {
                        isLoggedIn = true; // Đã đăng nhập
                      });
                      Navigator.push(context,MaterialPageRoute(
                        builder: (context) => GeneralInterface(isLoggedIn: isLoggedIn,),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  FirebaseAuth.instance.signInWithCredential(credential)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        isLoggedIn = true; // Đã đăng nhập
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => GeneralInterface(isLoggedIn: isLoggedIn,)),
                            (route) => false,
                      );
                    }
                  }).catchError((error) {
                    print(error);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('asset/images/logo_google.png',height: 20,width: 20,),
                      SizedBox(width: 10), Text('Đăng nhập bằng Google', style: TextStyle(fontSize: 16),),
                    ],),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                  ),
                ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  'Đăng ký tài khoản',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

