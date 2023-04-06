import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/screens/authenticate/signup.dart';
import 'package:farmmitra/screens/trader/profile_trader.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:farmmitra/screens/home/home.dart';
import 'package:farmmitra/screens/home/homet.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BottomNavBarT extends StatefulWidget {

  const BottomNavBarT({Key? key, this.page}) : super(key: key);
  final int? page;


  @override
  State<BottomNavBarT> createState() => _BottomNavBarTState();
}

class _BottomNavBarTState extends State<BottomNavBarT> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[

    HomeScreenT(),

    SignUp(),

    ProfileTrader()


  ];

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xff6200ee),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.padding_rounded,
              ),
              label: 'Hoe',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
