import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/screens/home_screen.dart';
import 'package:nourish_mart/widgets/app_spinner.dart';
import 'package:nourish_mart/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    addressController.dispose();
    stateController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add User Details'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: AppSpinner(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 10.0),
                child: Center(
                  child: Column(
                    children: [
                      textField(
                        hintText: 'First Name',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: fnameController,
                      ),
                      textField(
                        hintText: 'Last Name',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: lnameController,
                      ),
                      textField(
                        hintText: 'Email',
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: emailController,
                      ),
                      textField(
                        hintText: 'Address',
                        icon: Icons.location_on_rounded,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: addressController,
                      ),
                      textField(
                        hintText: 'State',
                        icon: Icons.location_on_rounded,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: stateController,
                      ),
                      textField(
                        hintText: 'City',
                        icon: Icons.location_city_rounded,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: cityController,
                      ),
                      textField(
                        hintText: 'Pincode',
                        icon: Icons.location_on_rounded,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: pincodeController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: CustomButton(
                            buttonText: 'Continue',
                            onPressed: () {
                              storeData();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField(
      {required String hintText,
      required IconData icon,
      required TextInputType inputType,
      required int maxLines,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.purple,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.purple,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  // Store user data to DB
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: '${fnameController.text} ${lnameController.text}',
        email: emailController.text,
        uid: ap.uid,
        phoneNumber: ap.phoneNumber);
    ap.saveUserDataToFireBase(
        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        });
  }
}
