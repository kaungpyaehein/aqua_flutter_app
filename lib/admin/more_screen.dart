import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
void signOut() {
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("More"),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}