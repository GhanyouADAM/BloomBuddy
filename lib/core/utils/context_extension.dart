
import 'package:flutter/material.dart';


extension BuildContextExtension on BuildContext{

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenheight => MediaQuery.of(this).size.height;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get txtTheme => Theme.of(this).textTheme;
  
}