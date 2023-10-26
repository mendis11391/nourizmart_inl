import 'package:flutter/material.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/screens/categories_screen.dart';
import 'package:nourish_mart/screens/user_registration_screen.dart';
import 'package:nourish_mart/utils/theme.dart';
import 'package:nourish_mart/utils/utils.dart';
import 'package:nourish_mart/widgets/app_spinner.dart';
import 'package:nourish_mart/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool otpResent = false;
  String? phone = '';
  @override
  void initState() {
    super.initState();
    triggerOtp();
  }

  void triggerOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs.getString('phone');
    });
  }

  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AppSpinner(),
                    ),
                  ],
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 45.0, 5.0, 0.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeColor.primaryColor,
                        ),
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          "assets/images/otp_img.png",
                          height: 300,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Enter the OTP sent to your phone number $phone",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ThemeColor.primaryShade200,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton(
                              buttonText: 'Verify',
                              onPressed: () {
                                if (otpCode != null) {
                                  verifyOtp(context, otpCode!);
                                } else {
                                  showSnackBar(context, "Enter 6-Digit code");
                                }
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextButton(
                            onPressed: resendOtp,
                            child: otpResent
                                ? AppSpinner()
                                : Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                        color: ThemeColor.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Verify OTP
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final dio = Dio();
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {
          ap.checkIfUserExists().then((value) async {
            if (value == true) {
              ap.setSignIn();
              // user exists
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ),
                  (route) => false);
            } else {
              // new user
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserRegisterationScreen(),
                  ),
                  (route) => false);
            }
          });
          // checking if user exists in DB
          // ap.checkExistingUser().then(
          //   (value) async {
          //     if (value == true) {
          //       ap.setSignIn();
          //       // user exists
          //       await Navigator.pushAndRemoveUntil(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const CategoriesScreen(),
          //           ),
          //           (route) => false);
          //     } else {
          //       // new user
          //       await Navigator.pushAndRemoveUntil(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const UserRegisterationScreen(),
          //           ),
          //           (route) => false);
          //     }
          //   },
          // );
        });
  }

  void resendOtp() {
    setState(() {
      otpResent = true;
    });
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, '$phone');
  }
}
