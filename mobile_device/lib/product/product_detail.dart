import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_device/cart/CartScreen.dart';
import 'package:mobile_device/product/products.dart';
import '../cart/Cart.dart';
import '../firebase/firebase_data.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import 'general_interface.dart';

class AppCatalog extends StatelessWidget {
  final Laptop laptop;
  final bool isLoggedIn;
  AppCatalog({Key? key, required this.laptop, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart?>(
      create: (context) => Cart(),
      lazy: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductDetail(laptop: laptop, isLoggedIn: isLoggedIn),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Laptop laptop;
  final bool isLoggedIn;

  ProductDetail({required this.laptop, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GeneralInterface(isLoggedIn: isLoggedIn,),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<Cart>(
          builder: (context, cart, child) => Column(
            children: [
              Container(
                child: Image.network(
                  "${laptop.hinhAnh}",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "${laptop.ten}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Giá chỉ còn:", style: TextStyle(fontSize: 20)),
                  SizedBox(width: 20),
                  Text(
                    "${laptop.gia}.đ",
                    style: TextStyle(fontSize: 20, color: Colors.red[500]),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "${laptop.moTa}",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.yellow[500]),
                  Icon(Icons.star, color: Colors.yellow[500]),
                  Icon(Icons.star, color: Colors.yellow[500]),
                  const Icon(Icons.star, color: Colors.grey),
                  const Icon(Icons.star, color: Colors.grey),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Hãng sản xuất: ${laptop.thuongHieu}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Hệ điều hành: ${laptop.heDieuHanh}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Màn hình: ${laptop.manHinh}",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Màu: ${laptop.mauSac}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Ổ đĩa: ${laptop.luuTru}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "RAM: ${laptop.ram}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Đồ họa: ${laptop.doHoa}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Bộ xử lý: ${laptop.boXuLy}",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoggedIn ? () {
                  final cart = Cart.instance;
                  cart.addToCart(laptop);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm vào giỏ hàng'),
                        content: Text('Đã thêm ${laptop.ten} vào giỏ hàng.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } : null,
                child: const Text('Thêm vào giỏ hàng'),
              ),
            ],
          ),
        ),
      )
    );
  }
}

