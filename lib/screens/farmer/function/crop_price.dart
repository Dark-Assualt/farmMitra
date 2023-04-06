import 'package:flutter/material.dart';

class CropPrice extends StatefulWidget {
  final String product;
const CropPrice({Key? key, required this.product}) : super(key: key);

  @override
  State<CropPrice> createState() => _CropPriceState();
}

class _CropPriceState extends State<CropPrice> {
  final amountController = TextEditingController();
  List<String> items = <String>[
    'One',
    'Two',
    'Three',
  ];
  String _dropdownValue="One";
  String _quantityVal = "Kg";
  List _quantity = [
    "Kg",
    "Ton",
  ];
@override
Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    leading: BackButton(color: Colors.black,),
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Update your crop price',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xfff76413),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Warehouse',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButton<String>(
                      elevation: 0,
                      hint: Text('Select Warehouse'),
                      isExpanded: true,
                      underline: Container(color: Colors.transparent,),
                      value: _dropdownValue,
                        items: items.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(widget.product,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    maxLength: 4,
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Price per",
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(width: 3, color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(width: 3,color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Text('/'),
                DropdownButton<String>(
                  elevation: 0,
                  value: _quantityVal,
                    items: _quantity.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                          child: Text(value));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _quantityVal = newValue!;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*(1/3),
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: Text('Update'),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
}
}
