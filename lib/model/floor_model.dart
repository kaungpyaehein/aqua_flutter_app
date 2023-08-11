import 'package:flutter/material.dart';

class FloorModel extends ChangeNotifier{
      List<String> options = [
      'Ground Floor/Elevator',
      '1st Floor',
      '3rd Floor',
      '4th Floor',
      '5th Floor',
      '6th Floor',
      '7th Floor',
      '8th Floor',
      '9th Floor',
      '10th Floor'
    ];
    String selectedOption = "Ground Floor/Elevator";
}