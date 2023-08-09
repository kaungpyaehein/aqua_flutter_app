import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                
                Row(
                  children: [
                    Text("Aqua",
                    style: GoogleFonts.arvo(
                      fontSize: 38,
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                const SizedBox(height: 5,),

                  
                Image.asset("assets/images/water_delivery_3.jpg",
                height: 300,),
                const SizedBox(height: 25,),

                Text(
                  "We deliver the most healthy water at your doorstep",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30,),


                 Text("Your reliable and much affordable purifed water supplier.",
                 textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.grey.shade900,
                  
                  fontSize: 22,
                ),),
                const SizedBox(height: 30,),

                GestureDetector(
                  onTap: () => AuthService().signInWithGoogle(),
                  child: Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/google logo.png", height: 30,),
                            Text("  Login with Google",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
