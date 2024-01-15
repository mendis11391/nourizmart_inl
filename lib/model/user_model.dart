class UserModel {
  num? nourishmartId;
  String uid;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String state;
  String district;
  String taluk;
  String area;
  String pincode;
  String landmark;
  String address;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.state,
    required this.district,
    required this.taluk,
    required this.area,
    required this.pincode,
    required this.landmark,
    required this.address,
  });

// From server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      state: map['state'] ?? '',
      district: map['district'] ?? '',
      taluk: map['taluk'] ?? '',
      area: map['area'] ?? '',
      pincode: map['pincode'] ?? '',
      landmark: map['landmark'] ?? '',
      address: map['address'] ?? '',
    );
  }

// To server
  Map<String, dynamic> toMap() {
    return {
      "nourishmartId": nourishmartId,
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "state": state,
      "district": district,
      "taluk": taluk,
      "area": area,
      "pincode": pincode,
      "landmark": landmark,
      "address": address,
    };
  }
}
