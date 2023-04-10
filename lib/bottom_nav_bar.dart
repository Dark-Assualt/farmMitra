import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/screens/authenticate/signup.dart';
import 'package:farmmitra/screens/farmer/chat_farmer.dart';
import 'package:farmmitra/screens/farmer/profile_farmer.dart';
import 'package:farmmitra/screens/farmer/request_live.dart';
import 'package:farmmitra/services/Maps.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:farmmitra/screens/home/home.dart';
import 'package:farmmitra/screens/home/homet.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BottomNavBar extends StatefulWidget {

  const BottomNavBar({Key? key, this.page}) : super(key: key);
  final int? page;


  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[

    HomeScreen(),

    RequestLive(),

    ChatFarmer(),

    ProfileFarmer(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("inside init state of Bottom nav bar");

    _selectedIndex = widget.page ?? 0;
    context.read<GenerateMaps>().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xff6200ee),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline_rounded,
                size: 30,
              ),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
              ),
              label: 'Message',
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
