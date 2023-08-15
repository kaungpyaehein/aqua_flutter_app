import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/last_order_widget.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/water_delivery_3.jpg",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Contact Us",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    "AQUA Team 1",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "AQUA",
                      style: GoogleFonts.oswald(
                          fontSize: 20,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    "09421128138",
                    style:
                        GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber("09421128138");
                    },
                    icon: const Icon(
                      Icons.call,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    "AQUA Team 2",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "AQUA",
                      style: GoogleFonts.oswald(
                          fontSize: 20,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    "09421128138",
                    style:
                        GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber("09421128138");
                    },
                    icon: const Icon(
                      Icons.call,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Last Order",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const LastOrder(),
            ],
          ),
        ),
      ),
    );
  }
}
