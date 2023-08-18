import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purifed_water_flutter/model/cart_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    // Fetch initial data from Firestore and populate the controllers
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((snapshot) {
      setState(() {
        nameController.text = snapshot.data()?['name'] ?? '';
        phoneController.text = snapshot.data()?['phone'] ?? '';
        addressController.text = snapshot.data()?['address'] ?? '';
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Consumer<CartProvider>(
          builder: (context, value, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Name",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Phone Number",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return DropdownButtonFormField<String>(
                        value: value.floorProvider().isNotEmpty
                            ? value.floorProvider()
                            : null,
                        onChanged: (newValue) {
                          setState(() {
                            value.selectedOption = newValue!;
                            Provider.of<CartProvider>(context, listen: false)
                                .updateOption(newValue);
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Choose your floor",
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        ),
                        items: value.options.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: addressController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter Address",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      if (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          addressController.text.isNotEmpty) {
                        addUserInfo(
                          nameController.text.trim(),
                          phoneController.text.trim(),
                          addressController.text.trim(),
                          value.selectedOption,
                        );
                        value.updateFloorPrice(value.selectedOption);

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Center(
                            child: Text("Info not enough!"),
                          ),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue.shade800),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Confirm",
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> addUserInfo(
    String name,
    String phone,
    String address,
    String floor,
  ) async {
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set(
      {
        "name": name,
        "phone": phone,
        "address": address,
        "floor": floor,
        "timeStamp": DateTime.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
