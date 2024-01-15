import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/model/user_register_model.dart';
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
  String _uid = '';
  String get uid => _uid;
  UserModel _userModel = UserModel(
    uid: '',
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    state: '',
    district: '',
    taluk: '',
    area: '',
    pincode: '',
    landmark: '',
    address: '',
  );
  UserModel get userModel => _userModel;
  UserRegisterModel _userRegisterModel = UserRegisterModel(
    firebaseId: '',
    firstName: '',
    lastName: '',
    mobile: '',
    email: '',
    state: '',
    district: '',
    area: '',
    pincode: 0,
    landmark: '',
  );
  UserRegisterModel get userRegisterModel => _userRegisterModel;
  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

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
    s.setString("uid", _uid);
    s.setString("phone", _phoneNumber);
    s.setString("userData", jsonEncode(_userRegisterModel));
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setString("phone", phoneNumber);
    _phoneNumber = phoneNumber;
    try {
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            showSnackBar(context, error.message.toString());
          },
          codeSent: (verificationId, forceResending) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
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
        _uid = user.uid;
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        onSuccess();
      }

      _isLoading = false;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    final String? savedUid = this._uid ?? s.getString(uid);
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("users").doc(savedUid).get();
    if (snapshot.exists) {
      // User exists
      return true;
    } else {
      // New user
      return false;
    }
  }

  Future<bool> checkIfUserExists() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    final String? savedUid = this._uid ?? s.getString(uid);
    final dio = Dio();
    final response = await dio
        .get('${AppEndpointURLs.serverUrl}/customer/customerExists/$savedUid');
    final data = response.data;
    if (response.statusCode == 200) {
      if (data.containsKey('exists')) {
        final data = response.data;
        final bool userExists = data['exists'];
        if (userExists) {
          return true;
        } else {
          return false;
        }
      } else {
        // New user
        return false;
      }
    } else {
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
          .doc(_uid)
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

  Future<void> registerUser(BuildContext context, UserModel userModel) async {
    final dio = Dio();

    final user = {
      'firebaseId': _uid,
      'first_name': userModel.firstName,
      'last_name': userModel.lastName,
      'mobile': userModel.phoneNumber,
      'email': userModel.email,
      'state': userModel.state,
      'district': userModel.district,
      'taluk': userModel.taluk,
      'area': userModel.area,
      'pincode': userModel.pincode,
      'landmark': userModel.landmark,
      'address': userModel.address,
    };

    try {
      final response = await dio.post(
        '${AppEndpointURLs.serverUrl}/saveUser',
        data: user,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('User saved successfully.');
      } else {
        print('Failed to save user: ${response.statusMessage}');
      }
    } catch (e) {
      print('Failed to save user: $e');
    } finally {
      dio.close();
    }
  }

  // Storing data locally - SP: Shared Preference
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "user_model",
      jsonEncode(
        userModel,
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
    if (_uid != null) {
      DocumentSnapshot snapshot =
          await _firebaseFireStore.collection("users").doc(_uid).get();
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

  Future<UserModel?> getUserDataFromFirestore(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // Convert the Firestore document into a UserModel object
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        // The document with the given UID does not exist
        return null;
      }
    } catch (e) {
      // Handle any errors here
      print('Error fetching user data: $e');
      return null;
    }
  }

  getUserData(String uid) async {
    try {
      final dio = Dio();
      //dynamic -> when we are not sure which type of data might come
      dynamic response = await dio
          .get('${AppEndpointURLs.serverUrl}/customer/customerInfo/$uid');
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
