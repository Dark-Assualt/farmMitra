import 'package:farmmitra/screens/farmer/function/crop_price.dart';
import 'package:farmmitra/screens/farmer/function/sell_product.dart';
import 'package:farmmitra/screens/farmer/function/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/Maps.dart';

class Functions extends StatefulWidget {
  final String type;
  final String category;
  final String product;
  const Functions({Key? key, required this.type, required this.category, required this.product}) : super(key: key);

  @override
  State<Functions> createState() => _FunctionsState();
}

class _FunctionsState extends State<Functions> {
  @override
  void initState() {
    Provider.of<GenerateMaps>(context,listen: false).getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.type == 'warehouse') {
      return FarmerScreen();
    }
    else if(widget.type == 'price') {
      return CropPrice(product: widget.product,);
    }
    else if(widget.type == 'sell') {
      return SellProduct(product: widget.product,);
    }
    else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }
}
