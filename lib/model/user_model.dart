import 'package:cloud_firestore/cloud_firestore.dart';

import '';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserModel {
  String name;
  String age;
  String gender;
  String userType;
  String createdAt;
  String phoneNumber;
  String profilePic;
  String uid;

  UserModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.userType,
    required this.createdAt,
    required this.phoneNumber,
    required this.profilePic,
    required this.uid,
  });

  // from map
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        age: map['age'] ?? '',
        gender: map['gender'] ?? '',
        userType: map['userType'] ?? '',
        createdAt: map['createdAt'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        profilePic: map['profilePic'] ?? '',
        uid: map['uid'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "userType": userType,
      "createdAt": createdAt,
      "phoneNumber": phoneNumber,
      "profilePic": profilePic,
      "uid": uid,
    };
  }

  UserModel copyWith({
    String? name,
    String? age,
    String? gender,
    String? userType,
    String? createdAt,
    String? phoneNumber,
    String? profilePic,
    String? uid,
    // String? lastMessageTime,
  }) =>
      UserModel(
        name: name ?? this.name,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        userType: userType ?? this.userType,
        createdAt: createdAt ?? this.createdAt,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profilePic: profilePic ?? this.profilePic,
        uid: uid ?? this.uid,
        // lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'] ?? '',
        age: json['age'] ?? '',
        gender: json['gender'] ?? '',
        userType: json['userType'] ?? '',
        createdAt: json['createdAt'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        profilePic: json['profilePic'] ?? '',
        uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "userType": userType,
      "createdAt": createdAt,
      "phoneNumber": phoneNumber,
      "profilePic": profilePic,
      "uid": uid,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data()!;
    return UserModel(
      name: data['name'],
      age: data['age'],
      gender: data['gender'],
      userType: data['userType'],
      createdAt: data['createdAt'],
      phoneNumber: data['phoneNumber'],
      profilePic: data['profilePic'],
      uid: data['uid'],

    );
  }
}
