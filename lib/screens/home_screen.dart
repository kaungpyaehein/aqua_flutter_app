import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purifed_water_flutter/screens/profile_screen.dart';

import '../model/cart_model.dart';
import '../widgets/item_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String greetings() {
      final hour = TimeOfDay.now().hour;

      if (hour <= 12) {
        return 'Good Morning,';
      } else if (hour <= 17) {
        return 'Good Afternoon,';
      }
      return 'Good Evening,';
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
           
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greetings().toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser!.email!,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileScreen(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                              child: Image.network(
                                  FirebaseAuth.instance.currentUser!.photoURL!,
                                  height: 80,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "It is \norder time!",
                      style: GoogleFonts.lora(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<CartModel>(
                builder: (context, value, child) {
                  return Row(
                    children: [
                      GroceryItemTile(
                        itemName: value.shopItems[0][0],
                        itemPrice: value.shopItems[0][1],
                        imagePath: value.shopItems[0][2],
                        color: value.shopItems[0][3],
                        title: value.shopItems[0][4],
                        count: value.big,
                        addItem: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(0),
                        removeItem: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .removeAnyItem(0),
                        onPressed: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(0),
                      ),
                      GroceryItemTile(
                        itemName: value.shopItems[1][0],
                        itemPrice: value.shopItems[1][1],
                        imagePath: value.shopItems[1][2],
                        color: value.shopItems[1][3],
                        title: value.shopItems[1][4],
                        count: value.small,
                        addItem: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(1),
                        removeItem: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .removeAnyItem(1),
                        onPressed: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(1),
                      ),
                    ],
                  );
                },
              ),
              // Expanded(
              //   child: Consumer<CartModel>(
              //     builder: (context, value, child) {
              //       return GridView.builder(
              //         itemCount: value.shopItems.length,
              //         physics: const NeverScrollableScrollPhysics(),
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           childAspectRatio: 2 / 1,
              //         ),
              //         itemBuilder: (context, index) {
              //           return AddRemoveTile(
              //               itemCount:
              //                   index == 0 ? value.bigBottle : value.smallBottle,
              //               itemName: value.shopItems[index][0],
              //               addItem: () =>
              //                   Provider.of<CartModel>(context, listen: false)
              //                       .addItemToCart(index),
              //               removeItem: () =>
              //                   Provider.of<CartModel>(context, listen: false)
              //                       .removeItemFromCart(index));
              // //         },
              //       );
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade800),
                  child: Consumer<CartModel>(builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Total cost : ",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            value.calculateTotal(),
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
