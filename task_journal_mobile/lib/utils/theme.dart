import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:task_journal_mobile/constants.dart';

const primary = Color(0xff23C686);
const primaryLight = Color(0xff2DEDA4);
const primaryDark = Color(0xff1CA670);
const secondary = Color(0xffFC9D45);
const secondaryDark = Color(0xffF28B2C);
const white = Colors.white;
const black = Colors.black;
const dark = Color(0xff1D3853);
const darkLight = Color(0xff7A9295);
const grayLight = Color(0xffFAFAFA);
const grayDark = Color(0xffF5F5F5);
const danger = Color(0xffF32013);
const starYellow = Color(0xffFFEA00);

var appBarIconTheme = const IconThemeData(
  color: white,
);

var appBarTextStyle = const TextStyle(
  color: white,
  fontSize: kAppBarFontSize,
);

var dangerTextStyle = const TextStyle(
  color: danger,
);

var hyperlinkTextStyle = const TextStyle(
  color: Color(0xFF0000EE),
);

var cardTextStyle = const TextStyle(
  fontSize: kCardFontSize,
);

var cardTheme = const CardTheme(
  color:  grayLight,
);

var navigationDrawerTextStyle = const TextStyle(
  color: white,
  fontSize: kDrawerHeaderFontSize,
);

var largeHeadingTextStyle = const TextStyle(
  color: white,
  fontSize: kLargeHeadingFontSize,
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

var elevatedButtonDangerStyle = ButtonStyle(
  foregroundColor: WidgetStateProperty.all(white),
  backgroundColor: WidgetStateProperty.all(danger),
  textStyle: WidgetStateProperty.all(const TextStyle(
    fontSize: 16.0,
    color: white,
  )),
);

var switchTheme = SwitchThemeData(
  overlayColor: WidgetStateProperty.all(primary),
);

var appBarTheme = AppBarTheme(
  backgroundColor: primary,
  titleTextStyle: appBarTextStyle,
  iconTheme: appBarIconTheme,
);

var textInputTheme = InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kInputBorderRadius),
    borderSide: const BorderSide(
      color: grayDark,
      width: 2.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kInputBorderRadius),
    borderSide: const BorderSide(
      color: danger,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kInputBorderRadius),
    borderSide: const BorderSide(
      color: primary,
      width: 2.0,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kInputBorderRadius),
    borderSide: const BorderSide(
      color: danger,
      width: 2.0,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kInputBorderRadius),
    borderSide: const BorderSide(
      color: grayDark,
      width: 2.0,
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kInputBorderRadius),
    borderSide: const BorderSide(
      color: grayDark,
      width: 2.0,
    ),
  ),
);

var dropdownTheme = DropdownMenuThemeData(
  inputDecorationTheme: InputDecorationTheme(
    constraints: const BoxConstraints(maxWidth: kTaskIconSelectWidth),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputBorderRadius),
      borderSide: const BorderSide(
        color: grayDark,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputBorderRadius),
      borderSide: const BorderSide(
        color: danger,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputBorderRadius),
      borderSide: const BorderSide(
        color: primary,
        width: 2.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputBorderRadius),
      borderSide: const BorderSide(
        color: danger,
        width: 2.0,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputBorderRadius),
      borderSide: const BorderSide(
        color: grayDark,
        width: 2.0,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kInputBorderRadius),
      borderSide: const BorderSide(
        color: grayDark,
        width: 2.0,
      ),
    ),
  ),
);

var containerDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(kInputBorderRadius)),
  border: Border.all(color: grayDark, width: 2.0),
);

var borderlessContainerDecoration = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(kInputBorderRadius)),
);

var drawerTheme = const DrawerThemeData(
  backgroundColor: white,
);

var appTheme = ThemeData(
  appBarTheme: appBarTheme,
  cardTheme: cardTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  switchTheme: switchTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: white),
  useMaterial3: true,
  dropdownMenuTheme: dropdownTheme,
  inputDecorationTheme: textInputTheme,
  scaffoldBackgroundColor: white,
  drawerTheme: drawerTheme,
);