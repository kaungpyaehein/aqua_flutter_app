// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  String name = "no name data";
  String phone = "no phone data ";
  String address = "no address data";
  String floor = "no floor data ";
  String note = "no note data";
  String email = FirebaseAuth.instance.currentUser!.email.toString();
  Future<List<Map<String, dynamic>>> infoProvider() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return []; // Return an empty list if the user is not authenticated
    }

    var snapshot = await FirebaseFirestore.instance
        .collection("user_info")
        .doc(user.email.toString())
        .get();

    var data = snapshot.data();
    if (data == null) {
      return []; // Return an empty list if user data is not found
    }

    var name = data["name"] ?? '';
    var phone = data["phone"] ?? '';
    var address = data["address"] ?? '';
    var floor = data["floor"] ?? '';
    var note = data["note"] ?? '';

    var userInfo = [
      {
        "name": name,
        "phone": phone,
        "address": address,
        "floor": floor,
        "note": note,
      }
    ];

    return userInfo;
  }

  String noteProvider() {
    FirebaseFirestore.instance
        .collection("order_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((snapshot) => {
              note = snapshot.data()?["note"] ?? '',
            });
    return note;
  }

  Future<void> fetchInfo() async {
    await FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((snapshot) => {
              name = snapshot.data()?["name"] ?? '',
              phone = snapshot.data()?["phone"] ?? '',
              address = snapshot.data()?["address"] ?? '',
              floor = snapshot.data()?["floor"] ?? '',
              note = snapshot.data()?["note"] ?? '',
            });
            notifyListeners();
  }
}
