import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/model/user_register_model.dart';
import 'package:nourish_mart/repository/app_repository.dart';
import 'package:nourish_mart/screens/otp_screen.dart';
import 'package:nourish_mart/utils/constants.dart';
import 'package:nourish_mart/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSendOTPLoading = false;
  bool get isSendOTPLoading => _isSendOTPLoading;
  bool _isResendOTPLoading = false;
  bool get isResendOTPLoading => _isResendOTPLoading;
  bool _isRegisterLoading = false;
  bool get isisRegisterLoading => _isRegisterLoading;
  String _firebaseId = '';
  String get firebaseId => _firebaseId;
  UserModel _userModel = UserModel(
      firebaseId: '',
      firstName: '',
      lastName: '',
      email: '',
      mobile: '',
      houseNo: '',
      street: '',
      stateId: '',
      districtId: '',
      pincodeId: '',
      areaId: '',
      landmark: '',
      isActive: '',
      createdBy: '');
  UserModel get userModel => _userModel;
  UserRegisterModel _userRegisterModel = UserRegisterModel(
      firebaseId: '',
      firstName: '',
      lastName: '',
      mobile: '',
      email: '',
      houseNo: '',
      street: '',
      stateId: '',
      districtId: '',
      pincodeId: '',
      areaId: '',
      landmark: '',
      isActive: '',
      createdBy: '');
  UserRegisterModel get userRegisterModel => _userRegisterModel;
  String _mobile = '';
  String get mobile => _mobile;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Repository repository = Repository();

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_SignedIn") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    s.setString("firebaseId", _firebaseId);
    s.setString("mobile", _mobile);
    s.setString("userData", jsonEncode(_userRegisterModel));
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(
      BuildContext context, String mobile, bool isResendOTP) async {
    isResendOTP == true ? _isResendOTPLoading = true : _isSendOTPLoading = true;
    notifyListeners();
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setString("mobile", mobile);
    _mobile = mobile;
    try {
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobile,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            isResendOTP == true
                ? _isResendOTPLoading = false
                : _isSendOTPLoading = false;
            notifyListeners();
            showSnackBar(context, error.message.toString());
          },
          codeSent: (verificationId, forceResending) {
            // _isSendOTPLoading = false;
            // notifyListeners();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            ).then((value) {
              isResendOTP == true
                  ? _isResendOTPLoading = false
                  : _isSendOTPLoading = false;
              notifyListeners();
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {
            isResendOTP == true
                ? _isResendOTPLoading = false
                : _isSendOTPLoading = false;
            notifyListeners();
          });
    } on FirebaseAuthException catch (e) {
      isResendOTP == true
          ? _isResendOTPLoading = false
          : _isSendOTPLoading = false;
      notifyListeners();
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        _firebaseId = user.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseId)
            .get();
        onSuccess();
      }

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    final String? savedfirebaseId = this._firebaseId ?? s.getString(firebaseId);
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("users").doc(savedfirebaseId).get();
    if (snapshot.exists) {
      // User exists
      return true;
    } else {
      // New user
      return false;
    }
  }

  Future<bool> checkIfUserExists() async {
    _isLoading = true;
    notifyListeners();
    final SharedPreferences s = await SharedPreferences.getInstance();
    final String? savedfirebaseId = this._firebaseId ?? s.getString(firebaseId);
    // final dio = Dio();
    // final response = await dio
    //     .get('${AppEndpointURLs.serverUrl}/customer/customerExists/$savedfirebaseId');

    final response = await repository.checkIfUserExists(savedfirebaseId!);

    if (response != null) {
      // var myData = response['exists'];
      // if (response.statusCode == 200) {
      // if ((myData as Map).containsKey('exists')) {
      // final data = response.data;
      _isLoading = false;
      notifyListeners();
      bool? userExists = response['exists'];
      if (userExists != null && userExists == true) {
        return true;
      } else {
        return false;
      }
      // } else {
      //   // New user
      //   return false;
      // }
    } else {
      _isLoading = true;
      notifyListeners();
      // New user
      return false;
    }
  }

  void saveUserDataToFireBase(
      {required BuildContext context,
      required UserModel userModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _userModel = userModel;
      await _firebaseFireStore
          .collection("users")
          .doc(_firebaseId)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerUser(
      BuildContext context, UserRegisterModel userRegisterModel) async {
    // final dio = Dio();

    // final user = {
    //   'firebaseId': _firebaseId,
    //   'first_name': userModel.firstName,
    //   'last_name': userModel.lastName,
    //   'mobile': userModel.mobile,
    //   'email': userModel.email,
    //   'house_no': userModel.houseNo,
    //   'street': userModel.street,
    //   'stateId': userModel.stateId,
    //   'districtId': userModel.districtId,
    //   'pincodeId': userModel.pincodeId,
    //   'areaId': userModel.areaId,
    //   'landmark': userModel.landmark,
    //   'is_active': userModel.isActive,
    //   'createdBy': userModel.createdBy
    // };
    _isRegisterLoading = true;
    notifyListeners();

    try {
      // final response = await dio.post(
      //   '${AppEndpointURLs.serverUrl}/saveUser',
      //   data: user,
      //   options: Options(
      //     headers: {
      //       'Content-Type': 'application/json',
      //     },
      //   ),
      // );

      final response = await repository.registerUser(userRegisterModel);

      if (response != null /*response.statusCode==200*/) {
        log('Register Response : $response');
        log('User saved successfully.');
        _isRegisterLoading = false;
        notifyListeners();
      } else {
        // log('Failed to save user: ${response.statusMessage}');
        log('Failed to save user: $response');
        _isRegisterLoading = false;
        notifyListeners();
      }
    } catch (e) {
      log('Failed to save user: $e');
      _isRegisterLoading = false;
      notifyListeners();
    } /*finally {
      dio.close();
    }*/
  }

  // Storing data locally - SP: Shared Preference
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "user_model",
      jsonEncode(
        userModel.toMap(),
      ),
    );
  }

  saveUserDataToStProc(userModelData) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    _userRegisterModel = userModelData;
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  signout() async {
    _firebaseAuth.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('user_model');
    await pref.setBool("is_signedin", false);
    _isSignedIn = false;
  }

  Future<UserRegisterModel?> getUserDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    final userDataString = s.getString("userData");
    if (userDataString != null) {
      final userDataMap = jsonDecode(userDataString);
      return UserRegisterModel.fromJson(userDataMap);
    }
    return null;
  }

  Future<bool> registeredUserLogin() async {
    if (_firebaseId != null) {
      DocumentSnapshot snapshot =
          await _firebaseFireStore.collection("users").doc(_firebaseId).get();
      if (snapshot.exists) {
        // User exists
        return true;
      } else {
        // New user
        return false;
      }
    } else {
      return false;
    }
  }

  Future<UserModel?> getUserDataFromFirestore(String firebaseId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseId)
          .get();

      if (userDoc.exists) {
        // Convert the Firestore document into a UserModel object
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        // The document with the given firebaseId does not exist
        return null;
      }
    } catch (e) {
      // Handle any errors here
      print('Error fetching user data: $e');
      return null;
    }
  }

  getUserData(String firebaseId) async {
    try {
      final dio = Dio();
      //dynamic -> when we are not sure which type of data might come
      dynamic response = await dio.get(
          '${AppEndpointURLs.serverUrl}/customer/customerInfo/$firebaseId');
      //final -> Assuming the data will definatily there.
      if (response != null) {
        // final data = response.data;
        final List<dynamic> responseData = response.data;
        final Map<String, dynamic> data = responseData[0];
        // UserRegisterModel resp = data;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
