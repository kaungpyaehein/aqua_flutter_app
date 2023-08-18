import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purifed_water_flutter/model/cart_provider.dart';
import 'package:purifed_water_flutter/widgets/details_tile.dart';

import '../screens/register_screen.dart';

class OrderDetailsAdmin extends StatefulWidget {
  
  const OrderDetailsAdmin({Key? key}) : super(key: key);

  @override
  State<OrderDetailsAdmin> createState() => _OrderDetailsAdminState();
}

class _OrderDetailsAdminState extends State<OrderDetailsAdmin> {
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
    // String noteProvider() {
    //   FirebaseFirestore.instance
    //       .collection("order_info")
    //       .doc(FirebaseAuth.instance.currentUser!.email.toString())
    //       .get()
    //       .then((snapshot) => {
    //             note = snapshot.data()?["note"] ?? '',
    //           });
    //   return note;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: userSnapshot,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final name = userData['name'] ?? '';
                  final phone = userData['phone'] ?? '';
                  final address = userData['address'] ?? '';
                  final floor = userData['floor'] ?? '';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            name,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: ClipOval(
                            child: Image.network(
                              FirebaseAuth.instance.currentUser!.photoURL
                                  .toString(),
                            ),
                          ),
                          subtitle: Text(
                            phone,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                FlutterPhoneDirectCaller.callNumber(phone);
                              },
                              icon: const Icon(
                                Icons.call,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Text(
                            "Delivery Address",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      floor,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      address,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 10),
                          child: Text(
                            "Order Summary",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              FutureBuilder<DocumentSnapshot>(
                  future: orderSnapshot,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                    final floor = orderData['floorFee'] ?? '';
                    final note = orderData['note'] ?? '';
                    final total = orderData['total'] ?? '';
                    final orderID = orderData['orderID'] ?? '';
                    return Consumer<CartProvider>(
                        builder: (context, value, child) {
                      if (big == 0 && small == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue.shade800),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Noting in cart, order now!",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(children: [
                            if (big != 0)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID :   ",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      orderID.toString(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            DetailsTile(
                              itemName: value.shopItems[0][0],
                              itemPrice: value.shopItems[0][1],
                              imagePath: value.shopItems[0][2],
                              color: value.shopItems[0][3],
                              title: value.shopItems[0][4],
                              count: "Qty ${big.toString()} ",
                              cost: big * int.parse(value.shopItems[0][1]),
                              addItem: () =>
                                  Provider.of<CartProvider>(context, listen: false)
                                      .addItemToCart(0),
                              removeItem: () =>
                                  Provider.of<CartProvider>(context, listen: false)
                                      .removeAnyItem(0),
                              onPressed: () =>
                                  Provider.of<CartProvider>(context, listen: false)
                                      .addItemToCart(0),
                            ),
                            if (small != 0)
                              DetailsTile(
                                itemName: value.shopItems[1][0],
                                itemPrice: value.shopItems[1][1],
                                imagePath: value.shopItems[1][2],
                                color: value.shopItems[1][3],
                                title: value.shopItems[1][4],
                                count: "Qty ${small.toString()} ",
                                cost: big * int.parse(value.shopItems[1][1]),
                                addItem: () => Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addItemToCart(1),
                                removeItem: () => Provider.of<CartProvider>(
                                        context,
                                        listen: false)
                                    .removeAnyItem(1),
                                onPressed: () => Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addItemToCart(1),
                              ),
                            DetailsTile(
                                itemName: "",
                                itemPrice: "100",
                                imagePath: "assets/images/delivery.png",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ));
                                },
                                addItem: () {},
                                removeItem: () {},
                                title: "Delivery Fee",
                                count:
                                    "- Floor ${floor == "Ground Floor/Elevator" ? 0 : (value.options.indexOf(value.floorProvider())).toString()} ",
                                cost: floor == "Ground Floor/Elevator"
                                    ? 0
                                    : (value.options
                                            .indexOf(value.floorProvider()) *
                                        100)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    child: Text(
                                      "Notes  ",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    note.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                   
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.blue.shade800),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent),
                                child: Consumer<CartProvider>(
                                    builder: (context, value, child) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total cost : ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade800),
                                        ),
                                        Text(
                                          "$total Ks",
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade800),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => const CheckOutScreen(),
                                  //     ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blue.shade800),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Done",
                                          style: GoogleFonts.openSans(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        );
                      }
                      // return Center(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 10, vertical: 6),
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(15),
                      //             color: Colors.blue.shade800),
                      //         child: Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(vertical: 20),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Text(
                      //                 "Empty cart, order now!",
                      //                 style: GoogleFonts.roboto(
                      //                     fontSize: 20,
                      //                     fontWeight: FontWeight.bold,
                      //                     color: Colors.white),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
