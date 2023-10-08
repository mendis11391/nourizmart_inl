class UserModel {
  String name;
  String email;
  String uid;
  String phoneNumber;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.phoneNumber,
  });

// From server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

// To server
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "phoneNumber": phoneNumber,
    };
  }
}
