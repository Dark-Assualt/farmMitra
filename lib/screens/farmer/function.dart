import 'package:farmmitra/screens/farmer/function/crop_price.dart';
import 'package:farmmitra/screens/farmer/function/sell_product.dart';
import 'package:farmmitra/screens/farmer/function/warehouse.dart';
import 'package:flutter/material.dart';

class Functions extends StatelessWidget {
  final String type;
  final String category;
  final String product;
  const Functions({Key? key, required this.type, required this.category, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(type == 'warehouse') {
      return Warehouse();
    }
    else if(type == 'price') {
      return CropPrice(product: product,);
    }
    else if(type == 'sell') {
      return SellProduct(product: product,);
    }
    else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }
}
