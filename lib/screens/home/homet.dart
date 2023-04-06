import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/trader/functiont.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenT extends StatefulWidget {
  const HomeScreenT({Key? key}) : super(key: key);

  @override
  State<HomeScreenT> createState() => _HomeScreenTState();
}

class _HomeScreenTState extends State<HomeScreenT> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Circle(0xff974141, 'Request Product', "assets/image/Sell.png", 84, 84, 'requestp'),
            SizedBox(height: 15,),
            Circle(0xff1325C2, 'Farm Connect', "assets/image/connect.png", 85, 76, 'chat'),
            SizedBox(height: 15,),
            Circle(0xffF6ACAC, 'In Stock', "assets/image/stock.png", 87, 92, 'liverequest'),
          ],
        ),
      ),
    ));
  }
  Widget Circle(int color, String text, String image, double w, double h, String _type) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FunctionsT(
          type: _type,
        )));
      },
      child: Container(
        width: 170,
        height: 170,
        decoration: BoxDecoration(
          color: Color(color),
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: w,
                height: h,
                child: Image.asset(image)
            ),
            SizedBox(height: 5,),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
