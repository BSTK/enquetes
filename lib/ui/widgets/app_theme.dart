import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(136, 14, 79, 1);
const kPrimaryColorDark = Color.fromRGBO(96, 0, 39, 1);
const kPrimaryColorLight = Color.fromRGBO(188, 71, 123, 1);

final kButtonTheme = ButtonThemeData(
    colorScheme: const ColorScheme.light(primary: kPrimaryColor),
    buttonColor: kPrimaryColor,
    splashColor: kPrimaryColorLight,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    )
);

const kTextTheme = const TextTheme(
    headline1: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w300,
        color: kPrimaryColorDark
    )
);

const kInputDecorationTheme = const InputDecorationTheme(
    enabledBorder: const UnderlineInputBorder(
    borderSide: const BorderSide(
        color: kPrimaryColorLight
      )
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: const BorderSide(
        color: kPrimaryColor
      )
    ),
    alignLabelWithHint: true
);

ThemeData appTheme() {
  return ThemeData(
      backgroundColor: Colors.white,
      accentColor: kPrimaryColor,
      primaryColor: kPrimaryColor,
      primaryColorDark: kPrimaryColorDark,
      primaryColorLight: kPrimaryColorLight,
      textTheme: kTextTheme,
      buttonTheme: kButtonTheme,
      inputDecorationTheme: kInputDecorationTheme
  );
}