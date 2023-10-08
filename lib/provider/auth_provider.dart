import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/screens/otp_screen.dart';
import 'package:nourish_mart/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
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
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
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
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      // User exists
      return true;
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
    await s.setString(
      "user_model",
      jsonEncode(
        userModelData.toMap(),
      ),
    );
  }

  signout() async {
    _firebaseAuth.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('user_model');
    await pref.setBool("is_signedin", false);
    _isSignedIn = false;
  }

  Future<UserModel?> getUserDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    final userDataString = s.getString("user_model");
    if (userDataString != null) {
      final userDataMap = jsonDecode(userDataString);
      return UserModel.fromMap(userDataMap);
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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(
              'users') // Replace 'users' with your Firestore collection name
          .doc(uid)
          .get();

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
}
