import 'package:farmmitra/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUserProvider extends ChangeNotifier {
  late final User _user;
  late final String _uid;
  late final String _userType;

  CurrentUserProvider() {
    _user = FirebaseAuth.instance.currentUser!;
    _uid = _user.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .get()
        .then((doc) {
      _userType = doc.data()!['usertype'];
      notifyListeners();
    });
  }

  String get uid => _uid;

  String get userType => _userType;
}
