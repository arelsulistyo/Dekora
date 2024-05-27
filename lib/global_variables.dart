import 'package:flutter/material.dart';

class GlobalVariables {
  // Colors
  static const primaryColor = Color(0xFFB44343);
  static const secondaryColor = Color(0xFFFFD8D9);

  // Gradients
  static const linearGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
