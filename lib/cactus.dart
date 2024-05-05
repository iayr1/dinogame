import 'dart:math';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import 'game_object.dart';
import 'sprite.dart';

List<Sprite> cacti = [
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_group.png"
    ..imageWidth = 104
    ..imageHeight = 100,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_large_1.png"
    ..imageWidth = 50
    ..imageHeight = 100,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_large_2.png"
    ..imageWidth = 98
    ..imageHeight = 100,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_small_1.png"
    ..imageWidth = 34
    ..imageHeight = 70,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_small_2.png"
    ..imageWidth = 68
    ..imageHeight = 70,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_small_3.png"
    ..imageWidth = 107
    ..imageHeight = 70,
];

class Cactus extends GameObject {
  final Sprite sprite;
  final Offset worldLocation;

  Cactus({required this.worldLocation}) : sprite = cacti[Random().nextInt(cacti.length)];

  @override
  Rect getRect(Size screenSize, double runDistance) {
    // Adjust the hitbox size to make it smaller
    double hitboxWidth = sprite.imageWidth.toDouble() * 0.5;
    double hitboxHeight = sprite.imageHeight.toDouble() * 0.5;

    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worlToPixelRatio + (sprite.imageWidth - hitboxWidth) / 2,
      screenSize.height / 1.75 - sprite.imageHeight + (sprite.imageHeight - hitboxHeight),
      hitboxWidth,
      hitboxHeight,
    ); 
  }

  @override
  Widget render() {
    return Image.asset(sprite.imagePath);
  }
}
