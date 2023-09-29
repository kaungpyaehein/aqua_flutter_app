import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/order_detail_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  void signOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Contacts"),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
          const SizedBox(height: 20,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("user_info")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 70,
                                      child: Text(
                                        orderData["name"].toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  title: Padding(
                                    padding:  const EdgeInsets.all(8.0),
                                    child: Text(orderData["phone"].toString(),
                                    style: const TextStyle(fontSize: 18,
                                    ),),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      Colors.blue.shade50),
                                        ),
                                        onPressed: (){
                                          FlutterPhoneDirectCaller.callNumber(orderData["phone"].toString());
                                        },
                                        child: const Icon(Icons.phone_sharp)),
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
        ),
      ),
    );
  }
}
