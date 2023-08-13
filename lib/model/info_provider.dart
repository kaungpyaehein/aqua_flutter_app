import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  List<Map<String, dynamic>> users = []; // List to store user data maps

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('user_info')
          .where('email', isEqualTo: user.email)
          .get();

      final dataList = querySnapshot.docs.map((doc) => doc.data()).toList();
      users = dataList.map((data) {
        return {
          'name': data['name'],
          'phone': data['phone'],
          'address': data['address'],
          'floor': data['floor'],
        };
      }).toList();

      notifyListeners();
      
    }
  }
}

// Example usage in a ListView


