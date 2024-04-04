import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:login_test/components/otp_screen.dart";

class HomeLoginScreen extends StatefulWidget {
  const HomeLoginScreen({super.key});
  @override
  State<HomeLoginScreen> createState() {
    return _HomeLoginState();
  }
}

class _HomeLoginState extends State<HomeLoginScreen> {
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    countryCodeController.text = "+91";
    super.initState();
  }

// for enabling and diabling the send code button based on user phoneNumber
  bool isButtonDisabled = true;
  // function to send otp
  void sendOtp() async {
    if (phoneNumberController.text.isNotEmpty &&
        countryCodeController.text.isNotEmpty) {
      var reqBody = {
        "mobileNumber": countryCodeController.text + phoneNumberController.text
      };
      var otpURL = dotenv.env["OTP_URL"];
      if (otpURL != null) {
        await http.post(Uri.parse(otpURL), body: reqBody);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 55,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        controller: countryCodeController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10)),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 38),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          controller: phoneNumberController,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                              hintText: "98XXXXXXXX "),
                          onChanged: (value) {
                            setState(() {
                              isButtonDisabled = value.length != 10;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () {
                          sendOtp();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                mobileNumber: countryCodeController.text +
                                    phoneNumberController.text,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[900],
                  ),
                  child: const Text(
                    "Send Code",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
