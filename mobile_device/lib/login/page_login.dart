import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'laptop_connect.dart';
import 'login_auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
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
                  hintText: 'Mật khẩu',
                ),
                obscureText: true,
                validator: (val) => val!.length < 6
                    ? 'Mật khẩu phải có ít nhất 6 ký tự'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() =>
                      error = 'Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin đăng nhập.');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaptopInterface(),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}