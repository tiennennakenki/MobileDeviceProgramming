import 'package:flutter/material.dart';
import '../firebase/firebase_data.dart';

class Cart extends ChangeNotifier {
  static Cart? _instance;
  List<Laptop> _items = [];
  List<VoidCallback> _listeners = [];
  int _cartItemCount = 0; // Thêm khai báo của _cartItemCount

  Cart();

  static Cart get instance {
    _instance ??= Cart();
    return _instance!;
  }

  List<Laptop> get items => _items;

  int get slMH_GioHang => _items.length;

  double get totalPrice {
    double total = 0;
    for (final laptop in _items) {
      total += double.parse(laptop.gia!) * laptop.quantity;
    }
    return total;
  }


  void addToCart(Laptop laptop) {
    _items.add(laptop);
    _updateCartItemCount();
    notifyListeners();
    notifyCartChanged();
  }

  void removeFromCart(Laptop laptop) {
    if (_items.contains(laptop)) {
      _items.remove(laptop);
      _updateCartItemCount();
      notifyListeners();
      notifyCartChanged();
    }
  }

  void increaseQuantity(Laptop laptop) {
    final index = _items.indexOf(laptop);
    if (index != -1) {
      final updatedLaptop = _items[index];
      updatedLaptop.quantity++;
      _items[index] = updatedLaptop;
      notifyListeners();
      notifyCartChanged();
    }
  }

  void decreaseQuantity(Laptop laptop) {
    final index = _items.indexOf(laptop);
    if (index != -1) {
      final updatedLaptop = _items[index];
      if (updatedLaptop.quantity > 1) {
        updatedLaptop.quantity--;
        _items[index] = updatedLaptop;
        notifyListeners();
        notifyCartChanged();
      }
    }
  }


  void notifyCartChanged() {
    for (final listener in _listeners) {
      listener();
    }
  }

  void addCartListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeCartListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _updateCartItemCount() {
    _cartItemCount = _items.length;
  }
}
