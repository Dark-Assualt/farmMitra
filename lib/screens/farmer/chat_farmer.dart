// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:farmmitra/model/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../provider/auth_provider.dart';
// import '../../provider/current_user_provider.dart';
// import '../chat_Screen.dart';
//
//
// // class UserListScreen extends StatelessWidget {
// //   const UserListScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final currentUserProvider = Provider.of<CurrentUserProvider>(context);
// //     final currentUserUid = currentUserProvider.uid;
// //     final userType = currentUserProvider.userType;
// //
// //     final usersRef = FirebaseFirestore.instance.collection('users');
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Users'),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: usersRef.snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }
// //
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Text('Loading...');
// //           }
// //
// //           final users = snapshot.data!.docs.map((doc) => UserModel.fromJson(doc.data() as
// //           Map<String, dynamic>)).toList();
// //
// //           return ListView.builder(
// //             itemCount: users.length,
// //             itemBuilder: (context, index) {
// //               final user = users[index];
// //               if (user.uid == currentUserUid) {
// //                 return SizedBox.shrink();
// //               }
// //
// //               return ListTile(
// //                 leading: CircleAvatar(
// //                   backgroundImage: NetworkImage(user.profilePic),
// //                 ),
// //                 title: Text(user.name),
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => ChatScreen(user: user,
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// class ChatsPage extends StatelessWidget {
//   const ChatsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       leading: BackButton(),
//       title: Text("Messages"),
//       elevation: 0,
//     ),
//     backgroundColor: Colors.blue,
//     body: SafeArea(
//       child: StreamBuilder<List<UserModel>>(
//         stream: AuthProvider.getUsers(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return Center(child: CircularProgressIndicator());
//             default:
//               if (snapshot.hasError) {
//                 print(snapshot.error);
//                 return buildText('Something Went Wrong Try later');
//               } else {
//                 final users = snapshot.data;
//
//                 if (users!.isEmpty) {
//                   return buildText('No Users Found');
//                 } else
//                   return Column(
//                     children: [
//                       ChatBodyWidget(users: users)
//                     ],
//                   );
//               }
//           }
//         },
//       ),
//     ),
//   );
//
//   Widget buildText(String text) => Center(
//     child: Text(
//       text,
//       style: TextStyle(fontSize: 24, color: Colors.white),
//     ),
//   );
// }
//
// class ChatBodyWidget extends StatelessWidget {
//   final List<UserModel> users;
//
//   const ChatBodyWidget({
//     required this.users,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Expanded(
//     child: Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       child: buildChats(),
//     ),
//   );
//
//   Widget buildChats() => ListView.builder(
//     physics: BouncingScrollPhysics(),
//     itemBuilder: (context, index) {
//       final user = users[index];
//       if( user.uid == FirebaseAuth.instance.currentUser!.uid) {
//         return SizedBox.shrink();
//       }
//       return Container(
//         height: 75,
//         child: ListTile(
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => ChatScreen(user: user),
//             ));
//           },
//           leading: CircleAvatar(
//             radius: 25,
//             backgroundImage: NetworkImage(user.profilePic),
//           ),
//           title: Text(user.name),
//         ),
//       );
//     },
//     itemCount: users.length,
//   );
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String chatId;
  final String user1Id;
  final String user2Id;

  const ChatScreen({Key? key, required this.name, required this.chatId, required this.user1Id, required this.user2Id}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _chatStream;

  @override
  void initState() {
    super.initState();
    _chatStream = FirebaseFirestore.instance.collection('chatsss').doc(widget.chatId).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: _chatStream,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var messages = snapshot.data!.data()!['messages'];
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var message = messages[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: message['sender_id'] == FirebaseAuth.instance.currentUser!.uid
                          ?Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        child: ListTile(
                          title: Align(alignment:Alignment.centerRight,
                          child: Text(message['text'], style: TextStyle(color: Colors.black),)),
                        ),
                      )
                          :Container(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: ListTile(
                          title: Align(alignment:Alignment.centerLeft,
                              child: Text(message['text'], style: TextStyle(color: Colors.black),)),
                        ),
                      ),

                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter message',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _sendMessage();
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String text = _textEditingController.text.trim();
    if (text.isNotEmpty) {
      Map<String, dynamic> message = {
        'text': text,
        'sender_id': widget.user1Id,
      };
      // Add this code to add the message to the messages array
      FirebaseFirestore.instance.collection('chatsss').doc(widget.chatId).update({
        'messages': FieldValue.arrayUnion([message]),
        'timestamp': FieldValue.serverTimestamp(), // add this line
      }).then((_) {
        _textEditingController.clear();
      }).catchError((error) {
        print('Error sending message: $error');
      });
    }
  }


}

class ChatListScreen extends StatefulWidget {
  final User currentUser;

  const ChatListScreen({required this.currentUser, Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List Screen'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var users = snapshot.data!.docs.where((doc) =>
          doc.id != widget.currentUser.uid);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              var user = users.elementAt(index);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['profilePic']),
                ),
                title: Text(user['name']),
                onTap: () async {
                  var name = user['name'];
                  var chatId = widget.currentUser.uid.compareTo(user.id) < 0
                      ? '${widget.currentUser.uid}_${user.id}'
                      : '${user.id}_${widget.currentUser.uid}';

                  var chatRef = FirebaseFirestore.instance.collection('chatsss')
                      .doc(chatId);
                  var chatDoc = await chatRef.get();
                  if (!chatDoc.exists) {
                    await chatRef.set({
                      'user1_id': widget.currentUser.uid,
                      'user2_id': user.id,
                      'messages': [],
                    });
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChatScreen(
                          name: name,
                          chatId: chatId,
                          user1Id: widget.currentUser.uid,
                          user2Id: user.id,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
