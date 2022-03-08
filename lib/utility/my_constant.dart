import 'package:flutter/material.dart';

class MyConstant {
  static String appName = 'Ung Library';

  static Color primary = const Color(0xff8ec943);
  static Color dark = const Color(0xff40241a);
  static Color light = const Color(0xffc1fc74);

  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeMyService = '/myService';

  BoxDecoration primaryBox() => BoxDecoration(color: primary.withOpacity(0.75));

  TextStyle h1Style() => TextStyle(
        color: dark,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        color: dark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        color: dark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
