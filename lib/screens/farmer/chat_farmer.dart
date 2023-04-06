import 'package:flutter/material.dart';

class ChatFarmer extends StatefulWidget {
  const ChatFarmer({Key? key}) : super(key: key);

  @override
  State<ChatFarmer> createState() => _ChatFarmerState();
}

class _ChatFarmerState extends State<ChatFarmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text('Chats'),

      ),
    );
  }
}
