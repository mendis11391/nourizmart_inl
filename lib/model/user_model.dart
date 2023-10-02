class UserModel {
  String name;
  String email;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
  });

// From server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

// To server
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
    };
  }
}
