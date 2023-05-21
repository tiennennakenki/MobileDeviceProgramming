import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_device/product/product_detail.dart';

import '../firebase/firebase_connect.dart';
import '../firebase/firebase_data.dart';

class ProductsPage extends StatelessWidget {
  final bool isLoggedIn;
  const ProductsPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFireBaseConnect(
      errorMessage: "Lỗi",
      connectingMessage: "Đang kết nối",
      builder: (context) => Products(laptop: Laptop(), isLoggedIn: isLoggedIn),
    );
  }
}

class Products extends StatelessWidget {
  final Laptop laptop;
  final bool isLoggedIn;

  const Products({Key? key, required this.laptop, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<LaptopSnapShot>>(
            stream: LaptopSnapShot.getAll2(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Lỗi", style: TextStyle(color: Colors.red)),
                );
              else if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                List<LaptopSnapShot> list = snapshot.data!;
                return GridView.extent(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  children: list
                      .map(
                        (sp) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              laptop: Laptop(
                                ten: sp.laptop!.ten,
                                gia: sp.laptop!.gia,
                                hinhAnh: sp.laptop!.hinhAnh,
                                moTa: sp.laptop!.moTa,
                              ),
                              isLoggedIn: isLoggedIn,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        shadowColor: Colors.blue,
                        child: Column(
                          children: [
                            Image.network(
                              "${sp.laptop!.hinhAnh}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            ),
                            Text("${sp.laptop!.ten}"),
                            Text(
                              "Giá: ${sp.laptop!.gia} VNĐ",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .toList(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
