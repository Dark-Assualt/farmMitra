import 'package:farmmitra/screens/authenticate/signup.dart';
import 'package:farmmitra/screens/farmer/vegetables.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatelessWidget {
  final String type;
  final String category;
  const SubCategory({Key? key, required this.type, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(category == 'Vegetables') {
      return Vegetables(type: type, category: category,);
    }
    else if(category == 'Fruits') {
      return SignUp();
    }
    else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }
}
