import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';
import 'game_object.dart';
import 'sprite.dart';

Sprite cloudSprite = Sprite()
  ..imagePath = "assets/images/cloud.png"
  ..imageWidth = 92
  ..imageHeight = 27;

class Cloud extends GameObject {
  final Offset worldLocation;
  final double speed; // Speed at which the cloud moves

  Cloud({required this.worldLocation, this.speed = 1.0});

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worlToPixelRatio / 5,
      screenSize.height / 3 - cloudSprite.imageHeight - worldLocation.dy,
      cloudSprite.imageWidth.toDouble(),
      cloudSprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return AnimatedCloud(
      sprite: cloudSprite,
      speed: speed,
    );
  }
}

class AnimatedCloud extends StatefulWidget {
  final Sprite sprite;
  final double speed;

  const AnimatedCloud({required this.sprite, this.speed = 1.0});

  @override
  _AnimatedCloudState createState() => _AnimatedCloudState();
}

class _AnimatedCloudState extends State<AnimatedCloud>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20), // Adjust duration as needed
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(2.0, 0.0), // Adjust end value to determine how far the cloud moves
    ).animate(_controller);
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset(
        widget.sprite.imagePath,
        width: widget.sprite.imageWidth.toDouble(),
        height: widget.sprite.imageHeight.toDouble(),
      ),
    );
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: Random().nextInt(2000)), () {
      _controller.repeat(reverse: true); // Start the animation
    });
  }
}
 