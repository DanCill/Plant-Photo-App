import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Color(0xff597445),
        primary: Color(0xff729762),
        secondary: Color(0xff658147)),
    scaffoldBackgroundColor: const Color(0xffE7F0DC));

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xff143601),
    primary: Color(0xff245501),
    secondary: Color(0xff73a942),
  ),
  scaffoldBackgroundColor: const Color(0xff172301),
);
