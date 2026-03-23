import 'dart:ui';

import 'package:flutter/material.dart';

enum House {
  all,
  gryffindor,
  slytherin,
  ravenclaw,
  hufflepuff,
}
extension HouseExtension on House {
  String get displayName {
    switch (this) {
      case House.all:
        return "All";
      case House.gryffindor:
        return "Gryffindor";
      case House.slytherin:
        return "Slytherin";
      case House.ravenclaw:
        return "Ravenclaw";
      case House.hufflepuff:
        return "Hufflepuff";
    }
  }


  Color get primaryColor {
    switch (this) {
      case House.gryffindor:
        return const Color(0xFF660000); // merah maroon
      case House.slytherin:
        return const Color(0xFF1A472A); // hijau
      case House.ravenclaw:
        return const Color(0xFF294163); // biru navy
      case House.hufflepuff:
        return const Color(0xFFFFD800); // kuning
      case House.all:
        return Colors.grey;
    }
  }

  Color get secondaryColor {
    switch (this) {
      case House.gryffindor:
        return const Color(0xFFe09c09); // gold
      case House.slytherin:
        return const Color(0xFFcccccc); // silver
      case House.ravenclaw:
        return const Color(0xFFaa8f7b); // bronze
      case House.hufflepuff:
        return const Color(0xFF1f1e19); // black
      case House.all:
        return Colors.black26;
    }
  }

  static House fromString(String? house) {
    switch (house?.toLowerCase()) {
      case "gryffindor":
        return House.gryffindor;
      case "slytherin":
        return House.slytherin;
      case "ravenclaw":
        return House.ravenclaw;
      case "hufflepuff":
        return House.hufflepuff;
      default:
        return House.all;
    }
  }


  String get image {
    switch (this) {
      case House.gryffindor:
        return "images/gryffindor-nobg.png";
      case House.slytherin:
        return "images/slytherin-nobg.png";
      case House.ravenclaw:
        return "images/ravenclaw-nobg.png";
      case House.hufflepuff:
        return "images/hufflepuff-nobg.png";
      case House.all:
        return "images/all-nobg.png";
    }
  }
}