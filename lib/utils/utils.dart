import 'dart:math';

import 'package:flutter/material.dart';

List<String> colorsList = ['red', 'green', 'blue', 'orange'];

String getRandomColorName() {
  final random = Random();
  final randomInt = random.nextInt(4);
  return colorsList[randomInt];
}

Color getColor(String text) {
  switch (text) {
    case 'red':
      return Colors.red.shade200;
    case 'green':
      return Colors.green.shade200;
    case 'blue':
      return Colors.blue.shade200;
    case 'orange':
      return Colors.orange.shade200;
    default:
      return Colors.orange.shade200;
  }
}

Color getTextColor(String text) {
  switch (text) {
    case 'red':
      return Colors.red.shade900;
    case 'green':
      return Colors.green.shade900;
    case 'blue':
      return Colors.blue.shade900;
    case 'orange':
      return Colors.orange.shade900;
    default:
      return Colors.orange.shade900;
  }
}
