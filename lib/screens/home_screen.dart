
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purifed_water_flutter/screens/check_out_screen.dart';

import '../model/cart_model.dart';
import '../widgets/item_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartModel>().floorProvider();
  }

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

    // Future<void> generateAndStoreOrder() async {
    //   // Generate a random order ID (you can customize the range as needed)
    //   Random random = Random();
    //   int orderID =
    //       random.nextInt(900000) + 100000; // Generates a 6-digit random number
    //
    //   // Store the order ID in Firestore
    //   try {
    //     await FirebaseFirestore.instance
    //         .collection('order_info')
    //         .doc(FirebaseAuth.instance.currentUser!.email.toString())
    //         .update({
    //       'orderID': orderID,
    //       // Other order-related data can be added here
    //     });
    //     print('Order ID $orderID stored successfully.');
    //   } catch (error) {
    //     print('Error storing order: $error');
    //   }
    // }

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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                greetings().toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                FirebaseAuth.instance.currentUser!.email!,
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "AQUA",
                          style: GoogleFonts.oswald(
                              fontSize: 38,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // Text(
                    //   "It is \norder time!",
                    //   style: GoogleFonts.lora(
                    //     fontSize: 35,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(
                height: 70,
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

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: GestureDetector(
                  onTap: () {
                    // if(context.read<CartModel>().big != 0  && context.read<CartModel>().big != 0) {
                    //   generateAndStoreOrder();
                    // }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckOutScreen(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.shade800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue",
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
