// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  String name = "no name data";
  String phone = "no phone data ";
  String address = "no address data";
  String floor = "no floor data ";

  List<String> infoProvider() {
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((snapshot) => {
              name = snapshot.data()?["name"] ?? '',
              phone = snapshot.data()?["phone"] ?? '',
              address = snapshot.data()?["address"] ?? '',
              floor = snapshot.data()?["floor"] ?? '',
            });
    return [name, phone, address, floor];
  }

  Future<void> fetchInfo() async {
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((snapshot) => {
              name = snapshot.data()?["name"] ?? '',
              phone = snapshot.data()?["phone"] ?? '',
              address = snapshot.data()?["address"] ?? '',
              floor = snapshot.data()?["floor"] ?? '',
            });
  }
}
