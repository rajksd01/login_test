import 'package:flutter/material.dart';
import "package:login_test/components/login_screen.dart";
import 'package:login_test/components/otp_screen.dart';

void main() {
  runApp( MaterialApp(
     debugShowCheckedModeBanner: false,
    initialRoute: "homeLogin",
    routes: {
      "homeLogin": (context) => const HomeLoginScreen(),
      "otp": (context) =>const  OtpScreen()
    },
  ));
}
