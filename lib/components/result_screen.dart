import "package:flutter/material.dart";
import "package:login_test/components/token_provider.dart";
import "package:provider/provider.dart";

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});
  @override
  State<ResultScreen> createState() {
    return _ResultScreen();
  }
}

class _ResultScreen extends State<ResultScreen> {
  @override
  Widget build(context) {
    return Consumer<TokenProvider>(
      builder: (context, tokenProviderModel, value) => Column(
        children: [
          Text(tokenProviderModel.token),
        ],
      ),
    );
  }
}
