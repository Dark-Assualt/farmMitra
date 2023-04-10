import 'package:flutter/material.dart';

class RequestProduct extends StatefulWidget {
  const RequestProduct({Key? key}) : super(key: key);

  @override
  State<RequestProduct> createState() => _RequestProductState();
}

class _RequestProductState extends State<RequestProduct> {
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  final rateController = TextEditingController();
  String _quantityValT = "Kg";
  List _quantityT = [
    "Kg",
    "Ton",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Column(
              children: [
                Text('Enter Your Requirements',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff89336),
                  ),),
                SizedBox( height: 30,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: productController,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "  Product Name",
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(width:3, color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(width:3, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                    color: Color(0xffD9D9D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.66,
                          child: TextField(
                            controller: quantityController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Quantity",
                              counterText: "",
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                            elevation: 0,
                            value: _quantityValT,
                            items: _quantityT.map((value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _quantityValT = newValue!;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                    color: Color(0xffD9D9D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.66,
                          child: TextField(
                            controller: rateController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Rate/",
                              counterText: "",
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                            elevation: 0,
                            value: _quantityValT,
                            items: _quantityT.map((value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _quantityValT = newValue!;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
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
                    child: Text('Finish'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
