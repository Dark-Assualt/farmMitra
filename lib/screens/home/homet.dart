import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/screens/trader/add_warehouse.dart';
import 'package:farmmitra/screens/trader/functiont.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/warehouse_model.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreenT extends StatefulWidget {

  const HomeScreenT({Key? key}) : super(key: key);

  @override
  State<HomeScreenT> createState() => _HomeScreenTState();
}

class _HomeScreenTState extends State<HomeScreenT> {
  final String uid = _auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Circle(0xff974141, 'Request Product', "assets/image/Sell.png", 84, 84, 'requestp'),
                SizedBox(height: 15,),
                Circle(0xff1325C2, 'Farm Connect', "assets/image/connect.png", 85, 76, 'chat'),
                SizedBox(height: 15,),
                Circle(0xffF6ACAC, 'In Stock', "assets/image/stock.png", 87, 92, 'liverequest'),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> AddWarehouseScreen()));
                  },
                  child:
                  Container(
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
                              Text("Add your warehouse"),
                              SizedBox(height: 5,),
                              Text("Add you warehouse location"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
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
  // Widget warehouse () {
  //  return StreamBuilder<QuerySnapshot>(
  //    stream: FirebaseFirestore.instance
  //        .collection('warehouses')
  //        .where('traderId', isEqualTo: uid)
  //        .snapshots(),
  //    builder: (context, snapshot) {
  //      if (snapshot.hasError){
  //        return Container(
  //          decoration: BoxDecoration(
  //            color: Colors.white,
  //            borderRadius: BorderRadius.circular(10),
  //            boxShadow: [BoxShadow(blurRadius: 15)],
  //            border: Border.all(width: 3, color: Colors.black),
  //          ),
  //          child:Text('Error: ${snapshot.error}'),
  //        );
  //      }
  //      if (!snapshot.hasData) {
  //        return  Container(
  //          decoration: BoxDecoration(
  //            color: Colors.white,
  //            borderRadius: BorderRadius.circular(10),
  //            boxShadow: [BoxShadow(blurRadius: 15)],
  //            border: Border.all(width: 3, color: Colors.black),
  //          ),
  //          child: CircularProgressIndicator(),
  //        );
  //      }
  //      final List<DocumentSnapshot> warehouses = snapshot.data!.docs;
  //      if (warehouses.isEmpty) {
  //        return Container(
  //          decoration: BoxDecoration(
  //            color: Colors.white,
  //            borderRadius: BorderRadius.circular(10),
  //            boxShadow: [BoxShadow(blurRadius: 15)],
  //            border: Border.all(width: 3, color: Colors.black),
  //          ),
  //          child: Padding(
  //            padding: const EdgeInsets.all(8.0),
  //            child: Row(
  //              mainAxisAlignment: MainAxisAlignment.center,
  //              children: [
  //                Icon(Icons.my_location_rounded),
  //                Column(
  //                  children: [
  //                    Text("Add your warehouse"),
  //                    SizedBox(height: 5,),
  //                    Text("Add you warehouse location"),
  //                  ],
  //                )
  //              ],
  //            ),
  //          ),
  //        );
  //      }
  //      else {
  //        return ListView.builder(
  //          itemCount: warehouses.length,
  //          itemBuilder: (context, index) {
  //            final Map<String, dynamic> warehouseData = warehouses[index].data();
  //            final String name = warehouseData['name'];
  //            final double latitude = warehouseData['latitude'];
  //            final double longitude = warehouseData['longitude'];
  //            final String address = 'Latitude: $latitude, Longitude: $longitude';
  //            return ListTile(
  //              title: Text(name),
  //              subtitle: Text(address),
  //            );
  //          },
  //        );
  //        //   ListView.builder(
  //        //   itemCount: warehouses.length,
  //        //   itemBuilder: (context, index) {
  //        //     final Map<String, dynamic> doc = warehouses[index].data as Map<String, dynamic>;
  //        //     final String name = doc['name'];
  //        //     final double latitude = doc['latitude'];
  //        //     final double longitude = doc['longitude'];
  //        //     final String address = 'Latitude: $latitude, Longitude: $longitude';
  //        //     return ListTile(
  //        //       title: Text(name),
  //        //       subtitle: Text(address),
  //        //     );
  //        //   },
  //        // );
  //      }
  //    },
  //  );
  // }
}
