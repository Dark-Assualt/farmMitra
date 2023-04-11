import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/screens/farmer/chat_farmer.dart';
import 'package:farmmitra/screens/trader/request_product.dart';
import 'package:farmmitra/screens/trader/requestt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class FunctionsT extends StatefulWidget {
  final String type;

  const FunctionsT({Key? key, required this.type}) : super(key: key);

  @override
  State<FunctionsT> createState() => _FunctionsTState();
}

class _FunctionsTState extends State<FunctionsT> {

  @override
  Widget build(BuildContext context)  {
    if(widget.type == 'requestp') {
      return RequestProduct();
    }
    else if(widget.type == 'chat') {

      return ChatListScreen(currentUser: FirebaseAuth.instance.currentUser!);
    }
    else if(widget.type == 'liverequest') {
      return RequestT();
    }
    else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }
}
