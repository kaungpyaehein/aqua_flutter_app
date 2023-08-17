import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/order_detail_screen.dart';

class DeliveredOrders extends StatelessWidget {
  const DeliveredOrders({super.key});

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
                  )),
              Text("Max",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  )),
              Text("Easy",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  )),
              Text("Deli Status",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
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
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemBuilder: (BuildContext context, int index) {
                      QuerySnapshot<Object?>? data = snapshot.data!;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails(id: data.docs[index]["id"].toString()),));
                            } ,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade500,
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "#${data.docs[index]["orderID"].toString()}"),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          data.docs[index]["big"].toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          data.docs[index]["small"].toString()),
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            Colors.green.shade50)),
                                            onPressed: () {},
                                            child:  Text("Delivered",style: TextStyle(color: Colors.green.shade700),)),
                                      )
                                    
                              ),
                            ),
                          ),
                          const Divider(color: Colors.black),
                        ],
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
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
