import 'package:flutter/material.dart';
import '../firebase/firebase_data.dart';


class Cart extends ChangeNotifier{
  static Cart? _instance;
  List<Laptop> _items = [];
  List<VoidCallback> _listeners = [];
  int get slMH_GioHang => _items.length;

  Cart();

  static Cart get instance {
    _instance ??= Cart();
    return _instance!;
  }

  List<Laptop> get items => _items;

  double get totalPrice {
    double total = 0;
    for (final laptop in _items) {
      total += double.parse(laptop.gia!);
    }
    return total;
  }

  void addToCart(Laptop laptop) {
    _items.add(laptop);
    notifyListeners();
  }

  void removeFromCart(Laptop laptop) {
    _items.remove(laptop);
    notifyListeners();
  }

  void addCartListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeCartListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}
