import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_data.dart';

class HomePage extends StatelessWidget {
  final Laptop laptop;
  final Stream<List<LaptopSnapShot>> laptopStream;

  HomePage({required this.laptop, required this.laptopStream});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            Image.network('https://genk.mediacdn.vn/thumb_w/640/2019/4/23/photo-2-15560365277901428846356.jpg'),
            Image.network('https://genk.mediacdn.vn/thumb_w/640/2019/4/23/photo-3-15560365277921416953914.jpg'),
            Image.network('https://genk.mediacdn.vn/thumb_w/640/2019/4/23/photo-4-1556036527794444591172.jpg  '),
            Image.network('https://genk.mediacdn.vn/thumb_w/640/2019/4/23/photo-5-155603652779689395547.jpg'),
            Image.network('https://genk.mediacdn.vn/thumb_w/640/2019/4/23/photo-6-15560365277991813245430.jpg'),
          ],
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
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
    );
  }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Container(
              child: Image.network(
                "${laptop.laptop!.hinhAnh}",
                fit: BoxFit.cover, width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "${laptop.laptop!.ten}",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            "${laptop.laptop!.gia}",
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}


