import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/authenticate/user_information_screen.dart';
import 'package:farmmitra/screens/home/home.dart';
import 'package:farmmitra/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Otp extends StatefulWidget {
  final String verificationId;
  const Otp({super.key, required this.verificationId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Center(
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
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 41,
                          width: 173,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                            image: AssetImage('assets/image/logo.png'),
                            fit: BoxFit.cover,
                          )),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 63,
                        ),
                        Container(
                          width: double.infinity,
                          // ignore: prefer_const_constructors
                          child: Text(
                            'Verify',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 20,
                        ),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        // ignore: prefer_const_constructors
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
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                showSnackbar(context, "Enter 6-digit code");
                              }
                            },
                            child: const Text('Verify code'),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false);
                                },
                                // ignore: prefer_const_constructors
                                child: Text(
                                  'Edit Phone Number?',
                                  style: const TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        // ignore: prefer_const_constructors
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

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {
          // checking whether user existes in the dp
          ap.checkExistingUser().then((value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInformationScreen()),
                  (route) => false);
            }
          });
        });
  }
}
