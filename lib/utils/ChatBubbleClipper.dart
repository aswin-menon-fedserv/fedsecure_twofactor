import 'dart:ui';

import 'package:flutter/material.dart';

class ChatBubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height); // Bottom-left curve
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 20); // Bottom-right curve
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}