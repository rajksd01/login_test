import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  var token = "";

  void addValuetoToken(receivedToken) {
    token = receivedToken;
    notifyListeners();
  }
}
