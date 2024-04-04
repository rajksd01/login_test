import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:login_test/components/token_provider.dart";
import "package:pinput/pinput.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({required this.mobileNumber, super.key});
  @override
  State<OtpScreen> createState() {
    return _OtpScreen();
  }
}

class _OtpScreen extends State<OtpScreen> {
  late String otp;
  String errorMessage = '';
  // proivder use garera token lai globally store garna xa
  //ani tyespaxi navigate garna xa
  //tyo vaisakesi photo khichna xa
  //ani tyo ni vaisakesi telai store garna xa db ma
  @override
  void initState() {
    super.initState();
    otp = "";
  }

  Future<String> authenticateOtp(String otp) async {
    var validateOtpUrl = Uri.parse(dotenv.env["USER_AUTHENTICATION_URL"]!);
    var bodyReqObject = {"mobileNumber": widget.mobileNumber, "otp": otp};
    var token = await http.post(validateOtpUrl, body: bodyReqObject);

    return token.body;
  }

  Future<String> _authenticateAndNavigate(String otp) async {
    var response = await authenticateOtp(otp);
    var jsonResponse = json.decode(response);
    if (jsonResponse['token'] != null && jsonResponse['token'] != '') {
      var token = jsonResponse['token']!;
      // Token received, navigate to the next page
      Navigator.pushNamed(context, "result");
      return token;
    } else {
      // Error occurred during authentication or token is empty
      // You can display an error message or handle the error as needed
      setState(() {
        errorMessage = 'Authentication failed. Please try again.';
      });
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // method for authenticating otp

    var otp = "";
    // Pinput Logic
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Consumer<TokenProvider>(
      builder: (context, tokenProviderModel, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '../assets/images/loginImage.png',
                  height: 130,
                  width: 130,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "We need to get you register before starting!.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Pinput Data Element
                Pinput(
                  length: 6,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  onCompleted: (pin) async {
                    setState(() {
                      otp = pin;
                    });
                    tokenProviderModel.token =
                        await _authenticateAndNavigate(otp);
                  },
                ),
                if (errorMessage.isNotEmpty) const Text("OTP is invalid"),
                const SizedBox(
                  height: 30,
                ),
                // SizedBox(
                //   height: 45,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       await _authenticateAndNavigate(otp);
                //       // if (token.isNotEmpty) {
                //       //   Navigator.pushNamed(context, "result");
                //       // }
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.amber[900],
                //     ),
                //     child: const Text(
                //       "Verify Phone Number",
                //       style: TextStyle(color: Colors.white, fontSize: 18),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'homeLogin', (route) => false);
                      },
                      child: const Text(
                        "Change Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
