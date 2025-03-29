import 'package:flutter/material.dart';

const primary = Color(0xff23C686);
const primaryLight = Color(0xff2DEDA4);
const primaryDark = Color(0xff1CA670);
const secondary = Color(0xffFC9D45);
const secondaryDark = Color(0xffF28B2C);
const white = Colors.white;
const dark = Color(0xff1D3853);
const darkLight = Color(0xff7A9295);
const grayLight = Color(0xffFAFAFA);
const grayDark = Color(0xffF5F5F5);
const danger = Color(0xffF32013);
const starYellow = Color(0xffFFEA00);

var cardTheme = const CardTheme(
  color: primary,
);

var elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(white),
    backgroundColor: WidgetStateProperty.all(primary),
    textStyle: WidgetStateProperty.all(const TextStyle(
      fontSize: 16.0,
      color: white,
    )),
  ),
);

var switchTheme = SwitchThemeData(
  overlayColor: WidgetStateProperty.all(primary),
);

var appTheme = ThemeData(
  cardTheme: cardTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  switchTheme: switchTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: primary),
);