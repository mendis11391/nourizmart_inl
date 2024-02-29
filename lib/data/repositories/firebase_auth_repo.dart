import '../../app/utils/app_export.dart';

class FirebaseAuthRepo extends GetxController {
  late final FirebaseAuth auth;
  late final Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    auth = FirebaseAuth.instance;
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
  }

  Future<bool> loginWithPhone(String mobile) async {
    await saveStorageValue(UserKeys.userMobileStr, mobile);
    String phone = '+91$mobile';
    Completer<bool> completer = Completer<bool>();
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (credential) async {
            await auth.signInWithCredential(credential);
          },
          codeSent: (verificationId, resendToken) async {
            await saveStorageValue(
                UserKeys.userVerificationIdStr, validString(verificationId));
            await resetLoading();
            showToast('OTP sent to your mobile', toastType: ToastType.success);
            if (!completer.isCompleted) {
              completer.complete(true);
            }
          },
          codeAutoRetrievalTimeout: (verificationId) async {
            appLog('Verification Time Out: $verificationId',
                logType: LogType.error);
            if (!completer.isCompleted) {
              await resetLoading();
              //showToast('Verification Time Out', toastType: ToastType.error);
              completer.complete(false);
            }
          },
          verificationFailed: (failed) async {
            await resetLoading();
            String msg = (validString(failed.code) == 'invalid-phone-number')
                ? 'The provided mobile number is not valid'
                : (!isFieldEmpty(failed.message)
                    ? validString(failed.message)
                    : 'Something went wrong. Try again!');
            showToast(msg, toastType: ToastType.error);
            if (!completer.isCompleted) {
              completer.complete(false);
            }
          });
    } on FirebaseAuthException catch (e) {
      appLog(e.code, logType: LogType.error);
      handleApiException((e.message), 'Login mobile');
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    } catch (ex) {
      handleApiException(ex, 'Login mobile');
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    }
    return completer.future;
  }

  handleApiException(dynamic error, String tag) async {
    showToast(validString(error), toastType: ToastType.error);
    await resetLoading();
  }

  resetLoading() async {
    await AppLoader.hideLoadingDialog();
  }

  Future<bool> verifyOtp(String verificationId, String otp) async {
    // int result = -1;
    bool isSuccess = false;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        await saveStorageValue(UserKeys.firebaseIdStr, user.uid);
        isSuccess = true;
        // DocumentSnapshot userDoc = await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user.uid)
        //     .get();
        //appLog(userDoc.data(), logType: LogType.json);
        // result = userDoc.exists ? 1 : 0;
        // return result;
        return isSuccess;
      } else {
        await resetLoading();
        showToast('Unable to verify your OTP');
        return isSuccess;
        // return result;
      }
    } on FirebaseAuthException catch (e) {
      appLog(e.code, logType: LogType.error);
      appLog(e.message, logType: LogType.error);
      if (validString(e.code) == 'invalid-verification-code') {
        handleApiException(
            'The verification code you entered is invalid. Please try again.',
            'Verify Otp');
      } else {
        handleApiException((e.message), 'Verify Otp');
      }
      return isSuccess;
      // return result;
    } catch (ex) {
      handleApiException(ex, 'Verify Otp');
      return isSuccess;
      // return result;
    }
  }

  Future<bool> signOut() async {
    await auth.signOut();
    return auth.currentUser == null;
  }
}
