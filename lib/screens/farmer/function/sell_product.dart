import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';

class Post {
  String name;
  String product;
  String quantity;
  String userType;
  String uid;
  File image;

  Post({
    required this.name,
    required this.product,
    required this.quantity,
    required this.userType,
    required this.uid,
    required this.image});
}

class SellProduct extends StatefulWidget {
  final String product;
  const SellProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  File? _image;
  final amounttController = TextEditingController();
  List<String> items = <String>[
    'One',
    'Two',
    'Three',
  ];
  String _dropdownValue="One";
  String _quantityVal = "Kg";
  List _quantity = [
    "Kg",
    "Ton",
  ];

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future<void> _savePost() async {
    if (amounttController.text.isNotEmpty && _image != null) {
      final Reference ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
      final UploadTask uploadTask = ref.putFile(_image!);
      final TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      final CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');
      final postDocument = postsCollection.doc();

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final name = userDoc['name'];
      final userType = userDoc['userType'];

      final data = {
        'name': name as String,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'product': widget.product,
        'quantity': amounttController.text + " " +_quantityVal,
        'userType': userType as String,
        'imageUrl': downloadUrl,
      };

      await postDocument.set(data);
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => Wrapper()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter text and select an image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Column(
              children: [
                Text('Confirm Sell Request',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff89336),
                ),),
                SizedBox( height: 30,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                    color: Color(0xffD9D9D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text(widget.product,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButton<String>(
                      elevation: 0,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                      underline: Container(color: Colors.transparent,),
                      value: _dropdownValue,
                      items: items.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                    color: Color(0xffD9D9D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.62,
                          // decoration: BoxDecoration(
                          //   color: Color(0xffD9D9D9),
                          // ),
                          child: TextField(
                            maxLength: 4,
                            controller: amounttController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Quantity",
                              counterText: "",
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                            elevation: 0,
                            value: _quantityVal,
                            items: _quantity.map((value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _quantityVal = newValue!;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () => _pickImage(),
                  child: _image == null
                      ? Container(
                    height: MediaQuery.of(context).size.height*(1/3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: Colors.black),
                    ),
                    child: Center(
                      child: Text('Add your image',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  )
                      : Container(
                    height: MediaQuery.of(context).size.height*(1/3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: Colors.black),
                    ),
                    child: Image.file(_image!),
                  ),
                  ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*(1/3),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {_savePost();},
                    child: Text('Save Request'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
