import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["20L", "800", "assets/images/big.jpeg", Colors.transparent, "Aqua Max"],
    ["1L", "300", "assets/images/small.jpeg", Colors.transparent, "Aqua Easy"],
  ];
  List _cartItems = [];

  int big = 0;
  int small = 0;
  get cartItems => _cartItems;

  get shopItems => _shopItems;

  List<String> options = [
    'Ground Floor/Elevator',
    '1st Floor',
    '2nd Floor',
    '3rd Floor',
    '4th Floor',
    '5th Floor',
    '6th Floor',
    '7th Floor',
    '8th Floor',
    '9th Floor',
    '10th Floor'
  ];
  double totalPrice = 0;
  String selectedOption = "Ground Floor/Elevator";
  String floorProvider() {
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((snapshot) => {
              selectedOption = snapshot.data()?["floor"] ?? '',
            });
    return selectedOption;
  }

  int _selectedOptionIndex = 0;

  get selectedOptionIndex => _selectedOptionIndex;
  void updateFloorPrice(String selectedFloor) {
    print(selectedFloor);
    _selectedOptionIndex = options.indexOf(selectedFloor);
    print(_selectedOptionIndex);
    notifyListeners();
    totalPrice += (_selectedOptionIndex * 100);
    notifyListeners();
    print(totalPrice);
  }

  void updateOption(String option) {
    // notifyListeners();
    // // // Find the index of the selected option in the options list
    // _selectedOptionIndex = options.indexOf(option);
    // notifyListeners();
    // // selectedOption = option;
    // // notifyListeners();
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set(
      {
        "floor": option,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  // final List _options = context.read<CartModel>().options;
  // final String selectedFloor = context.read<CartModel>().selectedOption;
  // _selectedOptionIndex = _options.indexOf(selectedFloor);
  // final int totalFloorFee = (100 * _selectedOptionIndex);
  // print(totalFloorFee);

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
    double totalWaterPrice = 0;

    for (int i = 0; i < _cartItems.length; i++) {
      totalWaterPrice += double.parse(_cartItems[i][1]);
    }
    double floorTotal = _selectedOptionIndex * 200;
    print(_selectedOptionIndex);
    print(floorTotal);
    return (totalWaterPrice + (_selectedOptionIndex * 100)).toStringAsFixed(0);
  }

  Future<void> checkout(
    int big,
    int small,
    String floorFee,
    String total,
    String note,
  ) async {
    FirebaseFirestore.instance
        .collection("order_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set(
      {
        "big": big,
        "small": small,
        "floorFee": floorFee,
        "total": total,
        "note": note,
        "timeStamp": DateTime.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  void resetValues() {
    _cartItems = [];
    notifyListeners();

    big = 0;
    notifyListeners();

    small = 0;
    notifyListeners();
    selectedOption = '';
    notifyListeners();
  }
}
