import 'package:flutter/material.dart';
import '../cart/Cart.dart';
import '../firebase/firebase_data.dart';
import '../product/product_detail.dart';

class CartScreen extends StatefulWidget {
  final bool isLoggedIn;
  const CartScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
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

class _CartScreenState extends State<CartScreen> {
  late Cart cart;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    cart = Cart.instance;
    calculateTotalPrice();
    cart.addCartListener(cartChanged);
  }

  @override
  void dispose() {
    cart.removeCartListener(cartChanged);
    super.dispose();
  }

  void cartChanged() {
    calculateTotalPrice();
    setState(() {});
  }

  void calculateTotalPrice() {
    double price = 0.0;
    for (var item in cart.items) {
      final double? gia = double.tryParse(item.gia ?? '');
      price += (gia ?? 0.0) * item.quantity;    }
    totalPrice = price;
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
                cart.removeFromCart(laptop);
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final laptop = cart.items[index];

              return Container(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2.0,
                  child: InkWell(
                    onTap: () {
                      // Xử lý khi người dùng nhấn vào ListTile
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            laptop.hinhAnh!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                laptop.ten!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Text('Số lượng: ${laptop.quantity}'),
                              Text(
                                'Giá: ${(int.tryParse(laptop.gia ?? '') ?? 0.0) * laptop.quantity} VND',
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            cart.decreaseQuantity(laptop);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            cart.increaseQuantity(laptop);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDeleteConfirmationDialog(laptop);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
                'Tổng cộng: ${numberWithCommas(totalPrice.toStringAsFixed(0))} VND',
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
    );
  }
}
