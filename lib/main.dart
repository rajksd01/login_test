import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:login_test/components/login_screen.dart";
import 'package:login_test/components/token_provider.dart';
import "package:login_test/components/result_screen.dart";
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TokenProvider()),
      ],
      child: const StartApp(),
    ),
  );
}

class StartApp extends StatelessWidget {
  const StartApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          //to check if token is empty and navigate them back to login screen
          if (tokenProvider.token.isEmpty) {
            return const HomeLoginScreen();
          } else {
            return const ResultScreen();
          }
        },
      ),
      routes: {
        "homeLogin": (context) => const HomeLoginScreen(),
        "result": (context) => const ResultScreen(),
      },
    );
  }
}
