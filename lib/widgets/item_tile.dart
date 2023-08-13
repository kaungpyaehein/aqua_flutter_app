// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  void Function()? onPressed;
  void Function()? addItem;
  void Function()? removeItem;
  final String title;
  final int count;

  GroceryItemTile({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.onPressed,
    required this.addItem,
    required this.removeItem,
    required this.title,
    required this.count, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                      color: Colors.blue.shade800,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // item image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10 ),
                child: Image.asset(
                  imagePath,
                  height: 150,
                ),
              ),
        
              // item name
              Text(
                itemName,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  '$itemPrice Ks',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: removeItem, icon: const Icon(Icons.remove)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        count.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  IconButton(onPressed: addItem, icon: const Icon(Icons.add)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
