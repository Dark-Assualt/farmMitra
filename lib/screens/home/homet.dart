import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/trader/add_warehouse.dart';
import 'package:farmmitra/screens/trader/functiont.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/warehouse_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreenT extends StatefulWidget {

  const HomeScreenT({Key? key}) : super(key: key);

  @override
  State<HomeScreenT> createState() => _HomeScreenTState();
}

class _HomeScreenTState extends State<HomeScreenT> {
  String? _warehouseName;
  String? _warehouseaddress;

  @override
  void initState() {
    super.initState();
    _checkWarehouseStatus();
  }

  Future<void> _checkWarehouseStatus() async {
    final QuerySnapshot warehouseSnap = await _firestore
        .collection('warehouses')
        .where('traderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (warehouseSnap.docs.isNotEmpty) {
      setState(() {
        _warehouseName = warehouseSnap.docs.first['name'];
        _warehouseaddress = warehouseSnap.docs.first['address'];
      });
    }
  }

    @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => HomeScreenT()));
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Circle(0xff974141, 'Request Product', "assets/image/Sell.png", 84, 84, 'requestp'),
                  SizedBox(height: 15,),
                  Circle(0xff1325C2, 'Farm Connect', "assets/image/connect.png", 85, 76, 'chat'),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> AddWarehouseScreen()));
                    },
                    child:_warehouseName != null
                      ? addWarehouse('$_warehouseName', '$_warehouseaddress')
                        : addWarehouse('Add Warehouse', 'Warehouse Address'),
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    ),
    );
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

  Widget addWarehouse (String name, String address) {
   return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 15)],
        border: Border.all(width: 3, color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.my_location_rounded),
            Column(
              children: [
                Text(name),
                SizedBox(height: 5,),
                Container(constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width*0.5,
                ),child: Text(address)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
