import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purifed_water_flutter/admin/admin_screen.dart';
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
            if(FirebaseAuth.instance.currentUser?.email == "kpthexoul@gmail.com"){
              return const AdminScreen();
            }
            // Already authenticated, navigate to the main page
            else {
              return const NaviPage();
            }
          } else {
            // Not authenticated, show the login screen
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
