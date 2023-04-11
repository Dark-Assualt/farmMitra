import 'package:farmmitra/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';

import 'package:farmmitra/screens/authenticate/otp.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  40, MediaQuery.of(context).size.height * 0.2, 40, 8),
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      'Welcome To',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 41,
                    width: 173,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                      image: AssetImage('assets/image/logo.png'),
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(
                    height: 63,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   height: 55,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 1, color: Colors.blue),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(
                  //         width: 15,
                  //       ),
                  //       SizedBox(
                  //         width: 40,
                  //         child: TextField(
                  //           controller: countryController,
                  //           keyboardType: TextInputType.phone,
                  //           maxLength: 4,
                  //           decoration: InputDecoration(
                  //             border: InputBorder.none,
                  //             counterText: "",
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 5,
                  //       ),
                  //       Expanded(
                  //           child: TextField(
                  //             keyboardType: TextInputType.phone,
                  //             maxLength: 10,
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: "Phone",
                  //               counterText: "",
                  //             ),
                  //           ))
                  //     ],
                  //   ),
                  // ),
                  TextFormField(
                    controller: phoneController,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Phone No.",
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      counterText: "",
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () => sendPhoneNumber(),
                      child: Text('Send Verification code'),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
