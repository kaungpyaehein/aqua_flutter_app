import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purifed_water_flutter/screens/login_screen.dart';
import 'package:purifed_water_flutter/screens/navi_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NaviPage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
