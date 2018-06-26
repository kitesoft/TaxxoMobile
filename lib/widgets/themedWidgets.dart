import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';


class ThemedCircularProgressIndicator extends CircularProgressIndicator {
  const ThemedCircularProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    double strokeWidth = 4.0,
    Animation<Color> valueColor: const AlwaysStoppedAnimation<Color>(const Color(0xFF00bba1)),
  }) : super(key: key, value: value, backgroundColor: backgroundColor, valueColor: valueColor, strokeWidth: strokeWidth);
}

