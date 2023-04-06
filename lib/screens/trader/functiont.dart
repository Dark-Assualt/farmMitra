import 'package:farmmitra/screens/farmer/chat_farmer.dart';
import 'package:farmmitra/screens/trader/request_product.dart';
import 'package:farmmitra/screens/trader/requestt.dart';
import 'package:flutter/material.dart';

class FunctionsT extends StatelessWidget {
  final String type;
  const FunctionsT({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(type == 'requestp') {
      return RequestProduct();
    }
    else if(type == 'chat') {
      return ChatFarmer();
    }
    else if(type == 'liverequest') {
      return RequestT();
    }
    else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }
}
