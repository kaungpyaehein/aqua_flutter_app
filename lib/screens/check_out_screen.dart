import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purifed_water_flutter/model/cart_model.dart';
import 'package:purifed_water_flutter/screens/register_screen.dart';
import 'package:purifed_water_flutter/widgets/checkout_tile.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Consumer<CartModel>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(children: [
            if (value.big != 0)
              CheckOutTile(
                itemName: value.shopItems[0][0],
                itemPrice: value.shopItems[0][1],
                imagePath: value.shopItems[0][2],
                color: value.shopItems[0][3],
                title: value.shopItems[0][4],
                count: value.big,
                cost: value.big * num.parse(value.shopItems[0][1]),
                addItem: () => Provider.of<CartModel>(context, listen: false)
                    .addItemToCart(0),
                removeItem: () => Provider.of<CartModel>(context, listen: false)
                    .removeAnyItem(0),
                onPressed: () => Provider.of<CartModel>(context, listen: false)
                    .addItemToCart(0),
              ),
            if (value.small != 0)
              CheckOutTile(
                itemName: value.shopItems[1][0],
                itemPrice: value.shopItems[1][1],
                imagePath: value.shopItems[1][2],
                color: value.shopItems[1][3],
                title: value.shopItems[1][4],
                count: value.small,
                cost: value.small * num.parse(value.shopItems[1][1]),
                addItem: () => Provider.of<CartModel>(context, listen: false)
                    .addItemToCart(1),
                removeItem: () => Provider.of<CartModel>(context, listen: false)
                    .removeAnyItem(1),
                onPressed: () => Provider.of<CartModel>(context, listen: false)
                    .addItemToCart(1),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade800),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/delivery.png",
                            height: 70,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Floor Fees",
                                  style: GoogleFonts.roboto(
                                    color: Colors.blue.shade800,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "for",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ));
                                },
                                child: Text(
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  value.floorProvider(),
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue.shade800),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  value.floorProvider() ==
                                          "Ground Floor/Elevator"
                                      ? "Free"
                                      : "${(value.options.indexOf(value.floorProvider()) * 100).toString()} Ks",
                                  style: GoogleFonts.roboto(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(18),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Total cost : ",
            //         style: GoogleFonts.roboto(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue.shade800),
            //       ),
            //       Text(
            //         ,
            //         style: GoogleFonts.roboto(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue.shade800),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade800),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent),
                child: Consumer<CartModel>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total cost : ",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800),
                        ),
                        Text(
                          "${value.calculateTotal()} Ks",
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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.streetAddress,
                controller: noteController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade500),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade800),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Leave a note (Optional)",
                  fillColor: Colors.grey.shade100,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: GestureDetector(
                onTap: () {
                  value.checkout(value.big, value.small, value.floorProvider(),
                      value.calculateTotal(), noteController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Oder Successful!")));
                  value.resetValues();
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Checkout",
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
            )
          ]),
        );
      }),
    );
  }
}
