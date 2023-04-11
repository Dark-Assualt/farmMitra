import 'package:farmmitra/screens/trader/profile_trader.dart';
import 'package:farmmitra/screens/trader/requestt.dart';
import 'package:farmmitra/screens/home/homet.dart';
import 'package:flutter/material.dart';


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

    RequestT(),

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
