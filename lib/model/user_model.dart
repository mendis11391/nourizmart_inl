class UserModel {
  // num? nourishmartId;
  dynamic /*uid*/ firebaseId;
  dynamic firstName;
  dynamic lastName;
  dynamic /*phoneNumber*/ mobile;
  dynamic email;
  dynamic houseNo;
  dynamic street;
  dynamic stateId;
  dynamic districtId;
  dynamic pincodeId;
  dynamic areaId;
  dynamic landmark;
  dynamic isActive;
  dynamic createdBy;

  UserModel(
      {required /*this.uid*/ this.firebaseId,
      required this.firstName,
      required this.lastName,
      required /*this.phoneNumber*/ this.mobile,
      required this.email,
      required this.houseNo,
      required this.street,
      required this.stateId,
      required this.districtId,
      required this.pincodeId,
      required this.areaId,
      required this.landmark,
      required this.isActive,
      required this.createdBy});

// From server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        // uid: map['uid'] ?? '',
        firebaseId: map['firebaseId'] ?? '',
        firstName: map['first_name'] ?? '',
        lastName: map['last_name'] ?? '',
        // phoneNumber: map['phoneNumber'] ?? '',
        mobile: map['mobile'] ?? '',
        email: map['email'] ?? '',
        houseNo: map['house_no'] ?? '',
        street: map['street'] ?? '',
        stateId: map['stateId'] ?? '',
        districtId: map['districtId'] ?? '',
        pincodeId: map['pincodeId'] ?? '',
        areaId: map['areaId'] ?? '',
        landmark: map['landmark'] ?? '',
        isActive: map['is_active'] ?? '',
        createdBy: map['createdBy'] ?? '');
  }

// To server
  Map<String, dynamic> toMap() {
    return {
      // "nourishmartId": nourishmartId,
      // "uid": uid,
      "fierbaseId": firebaseId,
      "first_name": firstName,
      "last_name": lastName,
      // "phoneNumber": phoneNumber,
      "mobile": mobile,
      "email": email,
      "house_no": houseNo,
      "street": street,
      "stateId": stateId,
      "districtId": districtId,
      "pincodeId": pincodeId,
      "areaId": areaId,
      "landmark": landmark,
      "is_active": isActive,
      "createdBy": createdBy
    };
  }
}
