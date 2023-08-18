import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/order_detail_screen.dart';

class DeliveredOrders extends StatefulWidget {
  const DeliveredOrders({super.key});

  @override
  State<DeliveredOrders> createState() => _DeliveredOrdersState();
}

class _DeliveredOrdersState extends State<DeliveredOrders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Order ID",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Max",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Easy",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Deli Status",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("order_info")
                .where("deliveryStatus", isEqualTo: "true")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error loading orders."),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No orders found."),
                );
              }
              if (snapshot.hasData && mounted) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      QuerySnapshot<Object?>? data = snapshot.data!;
                      if (index >= 0) {
                        DocumentSnapshot orderDoc = data.docs[index];
                        Map<String, dynamic> orderData =
                            orderDoc.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                  id: orderDoc.id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                FirebaseFirestore.instance
                                    .collection("order_info")
                                    .doc(orderDoc.id)
                                    .update(
                                  {
                                    "deliveryStatus": "false",
                                  },
                                );
                              },
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "#${orderData["orderID"].toString()}",
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(orderData["big"].toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(orderData["small"].toString()),
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.green.shade50),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Delivered",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(); // Return an empty container for invalid indices
                      }
                    },
                  ),
                );
              } else {
                return Container();
              }
            }),
      ],
    );
  }
}
