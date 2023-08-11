import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final double _floorFee = 100;
  final double _floors = 0;
  final List _shopItems = [
    ["20L", "800", "assets/images/big.jpeg", Colors.transparent, "Aqua Max"],
    ["1L", "300", "assets/images/small.jpeg", Colors.transparent, "Aqua Easy"],
  ];
  final List _cartItems = [];

  int big = 0;
  int small = 0;
  get cartItems => _cartItems;

  get shopItems => _shopItems;
  List<String> options = [
    'Ground Floor/Elevator',
    '1st Floor',
    '3rd Floor',
    '4th Floor',
    '5th Floor',
    '6th Floor',
    '7th Floor',
    '8th Floor',
    '9th Floor',
    '10th Floor'
  ];
  String selectedOption = "Ground Floor/Elevator";

  void updateOption(String option) {
    selectedOption = option;
    notifyListeners();
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set(
            {
          "floor": option,
        },
            SetOptions(
              merge: true,
            ));
  }

  void addItemToCart(int index) {
    if (index == 0) {
      big++;
      notifyListeners();
    } else {
      small++;
      notifyListeners();
    }
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    if (_cartItems[index] == _shopItems[0]) {
      if (big > 0 && big != 0) {
        big--;
      }
      notifyListeners();
    } else {
      if (small > 0 && small != 0) {
        small--;
      }
      notifyListeners();
    }
    _cartItems.removeAt(index);

    notifyListeners();
  }

  void removeAnyItem(int index) {
    if (index == 0) {
      if (big > 0) {
        big--;
        notifyListeners();
        if (_cartItems.isNotEmpty) {
          _cartItems.removeLast();
          notifyListeners();
          print(_cartItems.length.toString());
        }
      }
    } else {
      if (small > 0) {
        small--;
        notifyListeners();
        if (_cartItems.isNotEmpty) {
          _cartItems.removeLast();
          notifyListeners();
          print(_cartItems.length.toString());
        }
      }
    }
  }

  String calculateTotal() {
    double totalPrice = 0;

    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
