import 'package:flutter/material.dart';
import '../cart/Cart.dart';
import '../firebase/firebase_data.dart';
import '../product/product_detail.dart';

class CartScreen extends StatefulWidget {
  final bool isLoggedIn;
  const CartScreen({super.key, required this.isLoggedIn});
  @override
  _CartScreenState createState() => _CartScreenState(isLoggedIn: isLoggedIn);
}

class _CartScreenState extends State<CartScreen> {
  final bool isLoggedIn;

  _CartScreenState({required this.isLoggedIn});
  @override
  void initState() {
    super.initState();
    Cart.instance.addCartListener(cartChanged);
  }

  @override
  void dispose() {
    Cart.instance.removeCartListener(cartChanged);
    super.dispose();
  }

  void cartChanged() {
    setState(() {});
  }

  void showDeleteConfirmationDialog(Laptop laptop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa mặt hàng'),
          content: Text('Bạn có chắc chắn muốn xóa ${laptop.ten} khỏi giỏ hàng?'),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xóa'),
              onPressed: () {
                Cart.instance.removeFromCart(laptop);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Cart.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final laptop = cart.items[index];

                return ListTile(
                  leading: Image.network(
                    laptop.hinhAnh!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(laptop.ten!),
                  subtitle: Text('Số lượng: 1'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDeleteConfirmationDialog(laptop);
                        },
                      ),
                      Text('Giá: ${laptop.gia} VND'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(laptop: Laptop(
                          ten: laptop.ten,
                          gia: laptop.gia,
                          hinhAnh: laptop.hinhAnh,
                          moTa: laptop.moTa,
                        ), isLoggedIn: isLoggedIn, ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tổng cộng: ${cart.totalPrice.toStringAsFixed(0)} VND',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi người dùng bấm vào nút thanh toán
                  },
                  child: Text('Thanh toán'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
