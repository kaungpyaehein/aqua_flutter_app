import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    Future<void> _simulateDelayedLoading() async {
    // Simulate a delay using Future.delayed
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    _simulateDelayedLoading();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "AQUA",
              style: GoogleFonts.oswald(
                  fontSize: 38,
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold),
            ),
           
            Image.asset(
              "assets/images/water_delivery_3.jpg",
            ),
           
            // const Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     // Row(
            //     //   mainAxisAlignment: MainAxisAlignment.end,
            //     //   children: [
            //     //     Container(
            //     //       decoration: BoxDecoration(
            //     //         color: Colors.blue.shade800,
            //     //         borderRadius: BorderRadius.circular(15),
            //     //       ),
            //     //       child: Padding(
            //     //         padding: const EdgeInsets.all(10.0),
            //     //         child: Text(
            //     //           "Just Stay Hydrated!",
            //     //           textAlign: TextAlign.left,
            //     //           style: GoogleFonts.roboto(
            //     //             color: Colors.white,
            //     //             fontSize: 25,
            //     //             fontWeight: FontWeight.bold,
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //     // Image.asset(
            //     //   "assets/images/hydrated.jpg",
            //     //   height: 200,
            //     // ),
            //   ],
            // ),
            
           
           
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: () => AuthService().signInWithGoogle(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google logo.png",
                            height: 30,
                          ),
                          Text(
                            "  Login with Google",
                            style: GoogleFonts.roboto(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
