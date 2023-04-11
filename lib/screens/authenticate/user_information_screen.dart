// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:farmmitra/model/user_model.dart';
import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/home/home.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:farmmitra/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  File? image;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final userTypeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    userTypeController.dispose();
  }

  List<String> gender = ["Male", "Female"];

  List<String> userType = ["Farmer", "Trader"];

  bool displayg = false;
  bool displayu = false;

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Create Profile",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 240, 135, 36),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => selectImage(),
                          child: image == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  radius: 50,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 50,
                                ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Name:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Age:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: double.infinity,
                          child: TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Gender:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        content(genderController, "Gender", gender, displayg),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "User Type:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        content(
                            userTypeController, "UserType", userType, displayu),
                        SizedBox(
                          height: 15,
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
                            onPressed: () => storeData(),
                            child: const Text('Next'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget content(controller, String type, list, bool display) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: double.infinity,
              child: TextField(
                showCursor: false,
                keyboardType: TextInputType.none,
                controller: controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        FocusScopeNode currentFocus = FocusScopeNode();
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        switch (type) {
                          case "Gender":
                            displayg = !displayg;
                            break;
                          case "UserType":
                            displayu = !displayu;
                            break;
                        }
                      });
                    },
                    child: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
            ),
            display
                ? Stack(
                  children: [Container(
                      height: 120,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1)),
                          ]),
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller.text = list[index];
                                  FocusScopeNode currentFocus = FocusScopeNode();
                                  if (currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  switch (type) {
                                    case "Gender":
                                      displayg = !displayg;

                                      break;
                                    case "UserType":
                                      displayu = !displayu;

                                      break;
                                  }
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  list[index],
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          })),
                    ),]
                )
                : SizedBox()
          ]),
        ),
      ),
    );
  }

  //STORE USER DATA TO DATABASE
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: nameController.text.trim(),
        age: ageController.text.trim(),
        gender: genderController.text.trim(),
        userType: userTypeController.text.trim(),
        createdAt: " ",
        phoneNumber: "",
        profilePic: " ",
        uid: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
          context: context,
          userModel: userModel,
          profilepic: image!,
          onSuccess: () {
            // once data is save we need to save it locally
            ap.saveUserDataToSP().then((value) => ap.setSignIn().then((value) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Wrapper()),
                    (route) => false)));
          });
    } else {
      showSnackbar(context, "Please upload profile pic");
    }
  }
}
