// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DetailsTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  void Function()? onPressed;
  void Function()? addItem;
  void Function()? removeItem;
  final String title;
  final String count;
  final num cost;
  DetailsTile({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.onPressed,
    required this.addItem,
    required this.removeItem,
    required this.title,
    required this.count,
    this.color,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.white,

          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: ClipOval(
            child: Image.asset(
              imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.blue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  itemName,
                  style: GoogleFonts.roboto(
                    color: Colors.blue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          subtitle:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "$itemPrice Ks",
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  count,
                  style: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  "$cost Ks",
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    // return Card(
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12),
    //       border: Border.all(color: Colors.blue.shade800),
    //       color: Colors.white,
    //     ),
    //     child: const Padding(
    //       padding: EdgeInsets.all(5.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           // Image.asset(
    //           //   imagePath,
    //           //   height: 70,
    //           // ),
    //           // Column(
    //           //   crossAxisAlignment: CrossAxisAlignment.start,
    //           //   children: [
    //           //     Row(
    //           //       children: [
    //           //         Container(
    //           //           decoration: BoxDecoration(
    //           //               borderRadius: BorderRadius.circular(10),
    //           //               color: Colors.grey.shade200),
    //           //           child: Padding(
    //           //             padding: const EdgeInsets.all(8.0),
    // child: Text(
    //   title,
    //   style: GoogleFonts.roboto(
    //     color: Colors.blue.shade800,
    //     fontSize: 18,
    //     fontWeight: FontWeight.bold,
    //   ),
    //           //             ),
    //           //           ),
    //           //         ),
    //           //         // item image

    //           //         // item name
    //           //         Padding(
    //           //           padding: const EdgeInsets.all(5.0),
    //           //           child: Text(
    //           //             itemName,
    //           //             style: GoogleFonts.roboto(
    //           //               fontSize: 16,
    //           //               fontWeight: FontWeight.bold,
    //           //             ),
    //           //           ),
    //           //         ),
    //           //       ],
    //           //     ),
    //           //     ElevatedButton(
    //           //       onPressed: onPressed,
    //           //       child: Text(
    //           //         '$itemPrice Ks',
    //           //         style: GoogleFonts.roboto(
    //           //           color: Colors.white,
    //           //           fontWeight: FontWeight.bold,
    //           //         ),
    //           //       ),
    //           //     ),
    //           //   ],
    //           // ),
    //           // Column(
    //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //   children: [
    //           //     IconButton(
    //           //         onPressed: addItem,
    //           //         icon: Icon(
    //           //           CupertinoIcons.add_circled_solid,
    //           //           color: Colors.blue.shade800,
    //           //         )),
    //           //         Text(
    //           //       "Qty",
    //           //       style: GoogleFonts.roboto(
    //           //         fontSize: 18,
    //           //         fontWeight: FontWeight.bold
    //           //       ),
    //           //     ),
    //           //     Text(
    //           //       count.toString(),
    //           //       style: GoogleFonts.roboto(
    //           //         fontSize: 20,
    //           //       ),
    //           //     ),
    //           //     IconButton(
    //           //         onPressed: removeItem,
    //           //         icon: Icon(
    //           //           CupertinoIcons.minus_circled,
    //           //           color: Colors.blue.shade800,
    //           //         )),
    //           //   ],
    //           // ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
