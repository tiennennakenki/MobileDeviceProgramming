import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_device/firebase/firebase_data.dart';

class ProductDetail extends StatelessWidget {
  final Laptop laptop;
  ProductDetail({required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: Column(
        children: [
          Container(
            child: Image.network("${laptop.hinhAnh}", fit: BoxFit.cover,),
          ),
          SizedBox(height: 15),
          Text(
            "${laptop.ten}",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Text(
                "${laptop.moTa}",
                style: TextStyle(fontSize: 20, color: Colors.black),
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
        ],
      ),
    );
  }
  }

