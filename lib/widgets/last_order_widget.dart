import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purifed_water_flutter/model/user_info_provider.dart';
import 'package:purifed_water_flutter/screens/order_detail_screen.dart';

class LastOrder extends StatefulWidget {
  const LastOrder({super.key});

  @override
  State<LastOrder> createState() => _LastOrderState();
}

class _LastOrderState extends State<LastOrder> {
  late Future<DocumentSnapshot> userSnapshot;
  late Future<DocumentSnapshot> orderSnapshot;
  final noteController = TextEditingController();
  late final String note;

  @override
  void initState() {
    super.initState();
    userSnapshot = FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    orderSnapshot = FirebaseFirestore.instance
        .collection("order_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: orderSnapshot,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snap.hasError) {
            return const Center(
              child: Text("Error fetching data"),
            );
          }
          if (!snap.hasData || snap.data == null) {
            return const Center(
              child: Text("No data available"),
            );
          }
          final orderData = snap.data!.data() as Map<String, dynamic>;

          final String deliveryStatus = orderData['deliveryStatus'];

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>   OrderDetails(id:  context.read<UserInfoProvider>().email,),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: deliveryStatus == "false"
                    ? Colors.blue.shade400
                    : Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // FutureBuilder<DocumentSnapshot>(
                    //   future: userSnapshot,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //     if (snapshot.hasError) {
                    //       return const Center(
                    //         child: Text("Error fetching data"),
                    //       );
                    //     }
                    //     if (!snapshot.hasData || snapshot.data == null) {
                    //       return const Center(
                    //         child: Text("No data available"),
                    //       );
                    //     }

                    //     final userData =
                    //         snapshot.data!.data() as Map<String, dynamic>;

                    //     final address = userData['address'] ?? '';
                    //     final floor = userData['floor'] ?? '';

                    //     return SizedBox(
                    //       width: 150,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             floor,
                    //             style: GoogleFonts.roboto(
                    //                 fontSize: 20, color: Colors.white),
                    //           ),
                    //           Text(
                    //             address,
                    //             style: GoogleFonts.roboto(
                    //                 fontSize: 20, color: Colors.white),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    FutureBuilder<DocumentSnapshot>(
                        future: orderSnapshot,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error fetching data"),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Center(
                              child: Text("No data available"),
                            );
                          }

                          final orderData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          final big = orderData['big'] ?? '';
                          final small = orderData['small'] ?? '';

                          final orderID = orderData['orderID'] ?? '';
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Order ID:  $orderID",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        if (big != 0)
                                          Text(
                                            "AQUA Max 20L  ",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        if (small != 0)
                                          Text(
                                            "AQUA Easy  1L  ",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        if (big != 0)
                                          Text(
                                            "Qty $big",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                color: Colors.grey.shade300),
                                          ),
                                        if (small != 0)
                                          Text(
                                            "Qty $small",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                color: Colors.grey.shade300),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
