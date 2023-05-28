import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_device/product/products.dart';

import '../cart/CartScreen.dart';
import '../firebase/firebase_data.dart';
import '../home/home_page.dart';
import '../login/page_login.dart';
import '../register/page_register.dart';
import '../user/user_page.dart';

class GeneralInterface extends StatelessWidget {
  final bool isLoggedIn;
  const GeneralInterface({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoreScreen(isLoggedIn: isLoggedIn),
    );
  }
}

class StoreScreen extends StatefulWidget {
  final bool isLoggedIn;
  const StoreScreen({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  _StoreScreenState createState() => _StoreScreenState(isLoggedIn: isLoggedIn);
}

class _StoreScreenState extends State<StoreScreen> {
  int _selectedIndex = 0;
  int _currentPageIndex = 0;
  final bool isLoggedIn;
  final List<String> _pagesName = [
    'home',
    'products',
    'cart',
    'user',
  ];
  _StoreScreenState({required this.isLoggedIn});
  String _appBarTitle = 'Cửa hàng';

  void _onItemTapped(int index) {

    setState(() {
      _selectedIndex = index;
      _currentPageIndex = index;
      // Cập nhật tiêu đề cho AppBar dựa trên trang hiện tại
      switch (_pagesName[_currentPageIndex]) {
        case 'home':
          _appBarTitle = 'Trang chủ';
          break;
        case 'products':
          _appBarTitle = 'Sản phẩm';
          break;
        case 'cart':
          _appBarTitle = 'Giỏ hàng';
          break;
        default:
          _appBarTitle = 'Cửa hàng';
      }
    });

    if (index == 3) {
      _showUserProfile(context);
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchKeyword = '';

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    searchKeyword = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nhập từ khóa tìm kiếm',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Hủy',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      child: Text('Tìm kiếm'),
                      onPressed: () {
                        // Xử lý tìm kiếm ở đây
                        print('Đã tìm kiếm: $searchKeyword');

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUserProfile(BuildContext context) async {
    setState(() {
      _selectedIndex = 3;
      _currentPageIndex = 3;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserPage(isLoggedIn: isLoggedIn,)),
    );

    setState(() {
      _selectedIndex = 0;
      _currentPageIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          if (_pagesName[_currentPageIndex] == 'products')
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _showSearchDialog(context),
            ),
        ],
      ),
      // drawer: isLoggedIn ?
      //   null :
      //   Drawer(
      //     child: Column(
      //       children: [
      //         UserAccountsDrawerHeader(
      //           accountName: Text("Phan Minh Tiến"),
      //           accountEmail: Text("tien.pm.62cntt@ntu.edu.vn"),
      //           currentAccountPicture: CircleAvatar(
      //             //child: Text("MT"),
      //             backgroundImage: AssetImage("asset/images/img.png"),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.login),
      //           title: Text("Đăng ký"),
      //           onTap: () {
      //             // Xử lý khi nhấn vào nút đăng nhập
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => RegisterPage(),
      //               ),
      //             );
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.login),
      //           title: Text("Đăng nhập"),
      //           onTap: () {
      //             // Xử lý khi nhấn vào nút đăng nhập
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => LoginPage(isLoggedIn: false),
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),),
      body: (() {
        switch (_pagesName[_currentPageIndex]) {
          case 'home':
            return HomePage(laptop: Laptop(), laptopStream: LaptopSnapShot.getAll2());
          case 'products':
            return ProductsPage(isLoggedIn: widget.isLoggedIn);
          case 'cart':
            return CartScreen(isLoggedIn: isLoggedIn);
          case 'user':
            return UserPage(isLoggedIn: isLoggedIn,);
          default:
            return Container();
        }
      })(),

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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 20.0,
        unselectedFontSize: 14.0,
        onTap: _onItemTapped,
      ),
    );
  }
}

