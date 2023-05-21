// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_device/firebase/firebase_data.dart';
// import 'package:mobile_device/login/page_login.dart';
// import 'package:mobile_device/product/product_detail.dart';
// import 'package:mobile_device/register/page_register.dart';
//
// import '../cart/Cart.dart';
// import '../cart/CartScreen.dart';
// import '../firebase/firebase_connect.dart';
//
// class LaptopInterface extends StatelessWidget {
//   final bool isLoggedIn;
//   const LaptopInterface({Key? key, required this.isLoggedIn}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MyFireBaseConnect(
//       errorMessage: "Lỗi",
//       connectingMessage: "Đang kết nối",
//       builder: (context) => PageLaptop(laptop: Laptop(), isLoggedIn: isLoggedIn),
//     );
//   }
// }
//
//
// class PageLaptop extends StatelessWidget {
//   final Laptop laptop;
//   PageLaptop({required this.laptop, required this.isLoggedIn});
//   final bool isLoggedIn;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase App"),
//       ),
//       drawer: isLoggedIn ?
//         null :
//           Drawer(
//             child: Column(
//               children: [
//                 UserAccountsDrawerHeader(
//                   accountName: Text("Phan Minh Tiến"),
//                   accountEmail: Text("tien.pm.62cntt@ntu.edu.vn"),
//                   currentAccountPicture: CircleAvatar(
//                     //child: Text("MT"),
//                     backgroundImage: AssetImage("asset/images/img.png"),
//                   ),
//                 ),
//               ListTile(
//               leading: Icon(Icons.login),
//               title: Text("Đăng ký"),
//               onTap: () {
//                 // Xử lý khi nhấn vào nút đăng nhập
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => RegisterPage(),
//                   ),
//                 );
//               },
//             ),
//               ListTile(
//               leading: Icon(Icons.shopping_cart),
//               title: Text("Giỏ hàng"),
//               onTap: () {
//                 // Điều hướng đến màn hình giỏ hàng ở đây
//                 // Ví dụ:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CartScreen(),
//                   ),
//                 );
//               },
//             ),
//               ListTile(
//                   leading: Icon(Icons.login),
//                   title: Text("Đăng nhập"),
//                   onTap: () {
//                     // Xử lý khi nhấn vào nút đăng nhập
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginPage(),
//                       ),
//                     );
//                   },
//                 ),
//           ],
//         ),),
//       body: StreamBuilder<List<LaptopSnapShot>>(
//           stream: LaptopSnapShot.getAll2(),
//           builder: (context, snapshot) {
//             if(snapshot.hasError)
//               return Center(
//                 child: Text("Lỗi", style: TextStyle(color: Colors.red)),
//               );
//             else if(!snapshot.hasData)
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             else {
//               List<LaptopSnapShot> list = snapshot.data!;
//                return GridView.extent(
//                  padding: EdgeInsets.only(top: 10,bottom: 10, left: 5,right: 5),
//                  maxCrossAxisExtent: 250,
//                  mainAxisSpacing: 10,
//                  childAspectRatio: 0.8,
//                  crossAxisSpacing: 10,
//                  children: list
//                      .map(
//                        (sp) => GestureDetector(
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => ProductDetail(laptop: Laptop(
//                              ten: sp.laptop!.ten,
//                              gia: sp.laptop!.gia,
//                              hinhAnh: sp.laptop!.hinhAnh,
//                              moTa: sp.laptop!.moTa,
//                            )),
//                          ),
//                        );
//                      },
//                      child: Card(
//                        elevation: 1,
//                        shadowColor: Colors.blue,
//                        child: Column(
//                          children: [
//                            Image.network("${sp.laptop!.hinhAnh}", fit: BoxFit.cover,width: double.infinity, height: 150,),
//                            Text("${sp.laptop!.ten}"),
//                            Text(
//                              "Giá: ${sp.laptop!.gia} VNĐ",
//                              style: TextStyle(color: Colors.red),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  )
//                      .toList(),
//
//                  //ListView.builder(
//               //   itemCount: list.length,
//               //   itemBuilder: (context, index) => ListTile(
//               //     leading: Text("${index + 1}"),
//               //     title: Text("${list[index].laptop!.ten}"),
//               //     subtitle: Text("${list[index].laptop!.gia}"),
//               //   ),
//               );
//             }
//           }
//       ),
//     );
//   }
// }
