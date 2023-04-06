import 'package:farmmitra/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestLive extends StatefulWidget {
  const RequestLive({Key? key}) : super(key: key);

  @override
  State<RequestLive> createState() => _RequestLiveState();
}

class _RequestLiveState extends State<RequestLive> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(
          'Request Live',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 32,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.18,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(36),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 36,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                parameter('Name:', ap.userModel.name),
                SizedBox(height: 5,),
                parameter('Product name:', ap.userModel.name),
                SizedBox(height: 5,),
                parameter('Quantity:', ap.userModel.name),
                SizedBox(height: 5,),
                parameter('Warehouse visited:', ap.userModel.name),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
  Widget parameter (String info, String userInfo) {
    return Row(
      children: [
        Text(info,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),),
        SizedBox(
          width: 5,
        ),
        Text(userInfo,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),),
      ],
    );
  }
}
