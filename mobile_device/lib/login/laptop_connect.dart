import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_device/firebase/firebase_data.dart';
import 'package:mobile_device/login/page_login.dart';
import 'package:mobile_device/register/page_register.dart';

import '../firebase/firebase_connect.dart';

class LaptopInterface extends StatelessWidget {
  const LaptopInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFireBaseConnect(
      errorMessage: "Lỗi",
      connectingMessage: "Đang kết nối",
      builder: (context) => PageLaptop(),
    );
  }
}

class PageLaptop extends StatelessWidget {
  const PageLaptop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase App"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Phan Minh Tiến"),
              accountEmail: Text("tien.pm.62cntt@ntu.edu.vn"),
              currentAccountPicture: CircleAvatar(
                //child: Text("MT"),
                backgroundImage: AssetImage("asset/images/img.png"),
              ),
            ),

            ListTile(
              leading: Icon(Icons.login),
              title: Text("Đăng nhập"),
              onTap: () {
                // Xử lý khi nhấn vào nút đăng nhập
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.login),
              title: Text("Đăng ký"),
              onTap: () {
                // Xử lý khi nhấn vào nút đăng nhập
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
            ),

          ],
        ),
      ),
      body: StreamBuilder<List<LaptopSnapShot>>(
          stream: LaptopSnapShot.getAll2(),
          builder: (context, snapshot) {
            if(snapshot.hasError)
              return Center(
                child: Text("Lỗi", style: TextStyle(color: Colors.red)),
              );
            else if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              var list = snapshot.data!;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Text("${index + 1}"),
                  title: Text("${list[index].laptop!.ten}"),
                  subtitle: Text("${list[index].laptop!.gia}"),
                ),
              );
            }
          }
      ),
    );
  }
}
