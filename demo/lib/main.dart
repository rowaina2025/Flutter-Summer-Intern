import 'package:demo/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: const[
            Color(0xFF2C3E50),
            Color(0xFFFD746C)
          ],
        ),
      ),
    ),
  );
}