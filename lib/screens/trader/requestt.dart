import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmmitra/screens/farmer/chat_farmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestT extends StatelessWidget {
  const RequestT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black,),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: Text(
            'Request Live',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (!snapshot.hasData) {
                return Text("No posts found");
              }

    final posts = snapshot.data!.docs;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return Card(
          color: Colors.blueGrey,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Name: ${post["name"]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Product Name: ${post["product"]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Quantity: ${post["quantity"]}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                post["imageUrl"] != null
                    ? Image.network(post["imageUrl"], width: 100, height: 200, fit: BoxFit.scaleDown)
                    : SizedBox.shrink(),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      final String user1Id = FirebaseAuth.instance.currentUser!.uid;
                      final String user2Id = post["uid"];
                      final String name=post["name"];
                      var chatId = user1Id.compareTo(user2Id) < 0
                      ? '${user1Id}_${user2Id}'
                          : '${user2Id}_${user1Id}';
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen(
                        name: name,
                        chatId: chatId,
                        user1Id: user1Id,
                        user2Id: user2Id,
                      )));

                    }, icon: Icon(Icons.message))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    },
    ),),
    );
  }
}
