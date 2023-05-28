import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_data.dart';

class HomePage extends StatelessWidget {
  final Laptop laptop;
  final Stream<List<LaptopSnapShot>> laptopStream;

  HomePage({required this.laptop, required this.laptopStream});

  final List<String> imageUrls = [
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/5/19/638201360570266680_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/5/8/638191577309244728_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/5/1/638184978240095804_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/5/9/638192507382260550_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/5/9/638192506299406641_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/5/8/638191610247003949_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109542455788427_F-C1_1200x300.png',
    'https://images.fpt.shop/unsafe/fit-in/1200x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/3/20/638149199266138019_F-C1_1200x300.png',
    // Thêm các đường dẫn ảnh khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.0),
          CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 150, // Độ cao của ảnh
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0, // 1.0 để chiều rộng đầy màn hình
              onPageChanged: (index, reason) {
                // Xử lý khi slide thay đổi
              },
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Sản phẩm mới nhất',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          StreamBuilder<List<LaptopSnapShot>>(
            stream: laptopStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Lỗi", style: TextStyle(color: Colors.red));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                List<LaptopSnapShot> list = snapshot.data!;
                return GridView.count(
                  crossAxisCount: 2, // Số cột
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(list.length, (index) {
                    LaptopSnapShot laptop = list[index];
                    return ProductCard(laptop: laptop);
                  }),
                );
              }
            },
          ),
        ],
      ),
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

class ProductCard extends StatelessWidget {
  final LaptopSnapShot laptop;

  const ProductCard({required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.network(
                "${laptop.laptop!.hinhAnh}",
                fit: BoxFit.cover, width: double.infinity,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "${laptop.laptop!.ten}",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              "Giá: ${numberWithCommas(laptop.laptop!.gia)} VNĐ",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}


