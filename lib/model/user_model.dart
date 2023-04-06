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
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        age: map['age'] ?? '',
        gender: map['gender'] ?? '',
        userType: map['userType'] ?? '',
        createdAt: map['createdAt'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        profilePic: map['profilePic'] ?? '',
        uid: map['uid'] ?? '');
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
}
