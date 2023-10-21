import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/screens/home_screen.dart';
import 'package:nourish_mart/widgets/app_spinner.dart';
import 'package:nourish_mart/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  UserModel? userData;
  late Future checkUserLoggedIn;
  bool isLoginClicked = false;

  @override
  void initState() {
    super.initState();
    // getUserData();
  }

  // void getUserData() async {
  //   final ap = Provider.of<AuthProvider>(context, listen: false);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final uid = ap.uid;
  //   final userData = await ap.getUserDataFromFirestore(uid);
  //   setState(() {
  //     this.userData = userData;
  //     ap.saveUserDataToStProc(userData);
  //     checkUserLoggedIn = ap.registeredUserLogin();
  //     checkUserLoggedIn.then((value) async {
  //       if (prefs.getBool('is_signedin') == true) {
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const HomeScreen(),
  //           ),
  //           (route) => false,
  //         );
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: pageHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
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
                  "Nourish Mart",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add your phone number, We will send you a verification code",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.purple,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          '+91',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    suffixIcon: phoneController.text.length > 9
                        ? Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: isLoginClicked
                      ? const SizedBox(height: 20, child: AppSpinner())
                      : CustomButton(
                          buttonText: 'Login',
                          onPressed: () => sendPhoneNumber()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    setState(() {
      isLoginClicked = true;
    });
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, '+91${phoneController.text}');
  }
}
