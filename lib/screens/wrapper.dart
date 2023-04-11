import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/bottom_nav_bar.dart';
import 'package:farmmitra/bottom_nav_bart.dart';
import 'package:farmmitra/model/user_model.dart';
import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/authenticate/signin.dart';
import 'package:farmmitra/screens/home/home.dart';
import 'package:farmmitra/screens/home/homet.dart';
import 'package:farmmitra/signed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String userdata ='';
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot)  {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            } else {
              if(ap.isSignedIn == true){
                if(userdata == 'Farmer'){
                  return BottomNavBar();
                } else if(userdata == 'Trader'){
                  return BottomNavBarT();
                } else {
                  return SignIn();
                }
              } else {
                return SignIn();
              }
            }
          }
      ),
    );
  }

  Future<String> getData() async{
    final ap = Provider.of<AuthProvider>(context, listen: false);
    await Future.delayed(Duration(seconds: 1));
    ap.getDataFromSP().whenComplete(() => userdata =ap.userModel.userType);
    return userdata;
  }
}