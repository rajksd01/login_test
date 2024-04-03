import "package:flutter/material.dart";
import "package:flutter/services.dart";

class HomeLoginScreen extends StatefulWidget {
  const HomeLoginScreen({super.key});
  @override
  State<HomeLoginScreen> createState() {
    return _HomeLoginState();
  }
}

class _HomeLoginState extends State<HomeLoginScreen> {
  TextEditingController countryCode = TextEditingController();
  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
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
                        controller: countryCode,
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
                  onPressed: () {
                    Navigator.pushNamed(context, "otp");
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
