import 'package:farmmitra/screens/farmer/sub_cat.dart';
import 'package:farmmitra/screens/farmer/vegetables.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final String type;
  const Category({Key? key, required this.type}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late String type;

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Categories',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xffffae4f),
            ),),
            SizedBox(height: 50,),
            Text('Select your type of Crop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 28,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                category("assets/image/fruits.png", 'Fruits'),
                SizedBox(width: 81,),
                category("assets/image/vegetables.png", 'Vegetables', ),
              ],
            ),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                category("assets/image/grains.png", 'Grains'),
                SizedBox(width: 81,),
                category("assets/image/spices.png", 'Spices'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget category(String image, String text,) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubCategory(type: type, category: text)));
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(image),fit: BoxFit.fill),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
