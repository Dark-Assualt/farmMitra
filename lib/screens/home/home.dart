import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/authenticate/signin.dart';
import 'package:farmmitra/screens/farmer/category.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:farmmitra/services/Maps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Provider.of<GenerateMaps>(context,listen: false).getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_sharp),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width*0.7,
                    ),
                      child: Text(finalAddress,
                      style: TextStyle(
                        fontSize: 10
                      ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Circle(0xffd05219, 'Nearest Warehouse', "assets/image/warehouse.png", 77, 79, 'warehouse'),
            SizedBox(height: 15,),
            Circle(0xff24861c, 'Update Crop Price', "assets/image/uprice.png", 96, 81, 'price'),
            SizedBox(height: 15,),
            Circle(0xff974141, 'Sell Product', "assets/image/Sell.png", 87, 84, 'sell'),
          ],
        ),
      ),
    ));
  }
  Widget Circle(int color, String text, String image, double w, double h, String _type) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Category(
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
