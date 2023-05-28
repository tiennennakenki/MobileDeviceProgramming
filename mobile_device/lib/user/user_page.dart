import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/auth_service.dart';
import '../login/page_login.dart';
import '../product/products.dart';
import '../register/page_register.dart';

enum Gender { male, female }

class UserPage extends StatefulWidget {
  final bool isLoggedIn;

  const UserPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<UserPage> createState() => isLoggedIn
      ? _UserPageState(isLoggedIn: isLoggedIn)
      : _UserPageNotLogin();
}

class _UserPageNotLogin extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tài khoản"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Đăng ký"),
            onTap: () {
              // Xử lý khi nhấn vào nút đăng ký
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Đăng nhập"),
            onTap: () {
              // Xử lý khi nhấn vào nút đăng nhập
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(isLoggedIn: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// TODO: Thêm phương thức setState và các trạng thái cần thiết tại đây
}

class _UserPageState extends State<UserPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Gender _selectedGender = Gender.male;
  final bool isLoggedIn;
  _UserPageState({required this.isLoggedIn});

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _addressController.text = prefs.getString('address') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _selectedGender = (prefs.getInt('gender') ?? 0) == 0
          ? Gender.male
          : Gender.female;
    });
  }


  Future<void> _updateUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', _nameController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setInt('gender', _selectedGender == Gender.male ? 0 : 1);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Thông tin cá nhân đã được cập nhật thành công.'),
          actions: [
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(isLoggedIn: false),
      ),
          (route) => false, // Xóa tất cả các màn hình còn lại trong stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người dùng'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Họ tên',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Giới tính',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Radio(
                    value: Gender.male,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value as Gender;
                      });
                    },
                  ),
                  Text('Nam'),
                  Radio(
                    value: Gender.female,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value as Gender;
                      });
                    },
                  ),
                  Text('Nữ'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Địa chỉ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Số điện thoại',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Cập nhật'),
                onPressed: _updateUserInfo,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
        currentIndex: 3,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 20.0,
        unselectedFontSize: 14.0,
        onTap: (index) {
          if (index != 3) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}