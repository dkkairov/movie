import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static final ButtonStyle linkButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Color(0xFFFF671F)),
    textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700
        )
    ),
  );
}