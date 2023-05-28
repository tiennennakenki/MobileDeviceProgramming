import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_device/product/product_detail.dart';

import '../firebase/firebase_connect.dart';
import '../firebase/firebase_data.dart';

class ProductsPage extends StatelessWidget {
  final bool isLoggedIn;
  final String searchKeyword;
  const ProductsPage({Key? key, required this.isLoggedIn, required  this.searchKeyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFireBaseConnect(
      errorMessage: "Lỗi",
      connectingMessage: "Đang kết nối",
      builder: (context) => Products(laptop: Laptop(), isLoggedIn: isLoggedIn, searchKeyword: searchKeyword),
    );
  }
}

String numberWithCommas(String? numberString) {
  if (numberString!.isEmpty) {
    return '';
  }

  final num number = num.parse(numberString);
  final String formattedString = number.toStringAsFixed(0);
  final List<String> parts = formattedString.split('');

  final List<String> formattedParts = [];
  int count = 0;
  for (int i = parts.length - 1; i >= 0; i--) {
    count++;
    formattedParts.add(parts[i]);
    if (count == 3 && i != 0) {
      formattedParts.add('.');
      count = 0;
    }
  }

  return formattedParts.reversed.join('');
}

class Products extends StatelessWidget {
  final Laptop laptop;
  final bool isLoggedIn;
  List<LaptopSnapShot> dsSach = [];

  Products({Key? key, required this.laptop, required this.isLoggedIn, required searchKeyword}) : super(key: key);

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
                            builder: (context) => AppCatalog(
                              laptop: Laptop(
                                ten: sp.laptop!.ten,
                                gia: sp.laptop!.gia,
                                hinhAnh: sp.laptop!.hinhAnh,
                                moTa: sp.laptop!.moTa,
                                boXuLy: sp.laptop!.boXuLy,
                                ram: sp.laptop!.ram,
                                heDieuHanh: sp.laptop!.heDieuHanh,
                                luuTru: sp.laptop!.luuTru,
                                thuongHieu: sp.laptop!.thuongHieu,
                                doHoa: sp.laptop!.doHoa,
                                mauSac: sp.laptop!.mauSac,
                                manHinh: sp.laptop!.manHinh,

                              ),
                              isLoggedIn: isLoggedIn,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        shadowColor: Colors.blue,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Image.network(
                                "${sp.laptop!.hinhAnh}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                              Text(
                                "${sp.laptop!.ten}",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Giá: ${numberWithCommas(sp.laptop!.gia)} VNĐ",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )
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
