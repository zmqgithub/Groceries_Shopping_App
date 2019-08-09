import 'package:flutter/material.dart';

class Fruit {
  String image;
  String name;
  String rate;
  String desc;
  String color;
  Nutrition nutritions;

  Fruit({this.image, this.name, this.rate, this.desc, this.color, this.nutritions});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
        image:  json['image'],
        name:   json['name'],
        rate:   json['rate'],
        desc:   json['desc'],
        color:  json['color'],
        nutritions: Nutrition.fromJson(json['nutritions'])
    );
  }
}

class Nutrition {
  Item value;
  Item fat;
  Item carbhyd;
  Item protein;

  Nutrition({this.value, this.fat, this.carbhyd, this.protein});

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      value:    Item.fromJson(json['value']),
      fat:      Item.fromJson(json['fat']),
      carbhyd:  Item.fromJson(json['carbhyd']),
      protein:  Item.fromJson(json['protein']),
    );
  }
}

class Item {
  String value;
  String desc;

  Item({this.value, this.desc});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      value: json['value'],
      desc:  json['desc'],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
