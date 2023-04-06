import 'package:farmmitra/model/vegetable.dart';
import 'package:farmmitra/screens/farmer/function.dart';
import 'package:flutter/material.dart';

class Vegetables extends StatelessWidget {
  final String type;
  final String category;
  Vegetables({Key? key, required this.type, required this.category}) : super(key: key);

  final List<Vegetable> vegetables = [
    Vegetable('Onion', 'onion.png'),
    Vegetable('Potato', 'potato.png'),
    Vegetable('Garlic', 'garlic.png'),
    Vegetable('Tomato', 'tomato.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Select your product',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff89336),
                ),
              ),
            ),
            SizedBox(height: 78,),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: vegetables.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> Functions(type: type, category: category, product: vegetables[index].name.toLowerCase(),))
                      );
                    },
                    child: Container(
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 130,
                            // color: Colors.greenAccent,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/image/${vegetables[index].imageAsset}'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(vegetables[index].name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      )),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
