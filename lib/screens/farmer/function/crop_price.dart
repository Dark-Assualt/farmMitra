import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Update {
  String name;
  String product;
  String rate;



  Update({
    required this.name,
    required this.product,
    required this.rate,
  });
}
class CropPrice extends StatefulWidget {
  final String product;
const CropPrice({Key? key, required this.product}) : super(key: key);

  @override
  State<CropPrice> createState() => _CropPriceState();
}

class _CropPriceState extends State<CropPrice> {

  String _selectedUserName = ' ';
  List<String> _userNames = [];

  @override
  void initState() {
    super.initState();
    getWarehouseNames();
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> getWarehouseNames() async {
    // Query Firestore to get a list of user names
    final usersQuerySnapshot = await FirebaseFirestore.instance.collection('warehouses').get();
    final users = usersQuerySnapshot.docs.map((doc) => doc.data()['name'] as String).toList();

    // Update the _userNames list and set the default selected user name
    setState(() {
      _userNames = users;
      _selectedUserName = _userNames.first;
    });
    print(users);
    return users;
  }

  void _onDropdownChanged(String? newValue) {
    setState(() {
      _selectedUserName = newValue!;
    });
  }

  final amountController = TextEditingController();
  String _dropdownValue = "Testcase 1";
  String _quantityVal = "Kg";
  List _quantity = [
    "Kg",
    "Ton",
  ];

  Future<void> _savePost() async {
    if (amountController.text.isNotEmpty ) {
      final CollectionReference upsCollection = FirebaseFirestore.instance.collection('cropPrice');
      final upDocument = upsCollection.doc();

      final ware = await FirebaseFirestore.instance
          .collection('warehouses')
          .where('name', isEqualTo: _selectedUserName)
          .get();

      final name = ware.docs[0].get('name');

      final data = {
        'name': name,
        'product': widget.product,
        'rate': "Rs."+amountController.text+'/'+_quantityVal,

      };

      await upDocument.set(data);

      CollectionReference collectionRef = FirebaseFirestore.instance.collection('warehouses');
      QuerySnapshot querySnapshot = await collectionRef.where('name', isEqualTo: _selectedUserName).get();
      // Iterate over all documents that match the query
      querySnapshot.docs.forEach((doc) {
        // Update each document with the new data
        collectionRef.doc(doc.id).update({'rate': "Rs."+amountController.text+'/'+_quantityVal});
      });

      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Wrapper()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter text')));
    }
  }

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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedUserName,
                      items: _userNames.map((String userName) {
                        return DropdownMenuItem<String>(
                          value: userName,
                          child: Text(userName),
                        );
                      }).toList(),
                      onChanged:_onDropdownChanged,
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
                onPressed: () {_savePost();},
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
