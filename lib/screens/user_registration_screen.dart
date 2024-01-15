import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/screens/categories_screen.dart';
import 'package:nourish_mart/widgets/app_spinner.dart';
import 'package:nourish_mart/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:nourish_mart/utils/theme.dart';

class UserRegisterationScreen extends StatefulWidget {
  const UserRegisterationScreen({super.key});

  @override
  State<UserRegisterationScreen> createState() =>
      _UserRegisterationScreenState();
}

class _UserRegisterationScreenState extends State<UserRegisterationScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final talukController = TextEditingController();
  final areaController = TextEditingController();
  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    stateController.dispose();
    districtController.dispose();
    talukController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    landmarkController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.primaryColor,
        title: Text('Register'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: AppSpinner(),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      textField(
                        hintText: 'First Name',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: firstNameController,
                      ),
                      textField(
                        hintText: 'Last Name',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: lastNameController,
                      ),
                      textField(
                        hintText: 'Email',
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: emailController,
                      ),
                      textField(
                        hintText: 'State',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: stateController,
                      ),
                      textField(
                        hintText: 'District',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: districtController,
                      ),
                      textField(
                        hintText: 'Taluk',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: talukController,
                      ),
                      textField(
                        hintText: 'Area',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: areaController,
                      ),
                      textField(
                        hintText: 'Pincode',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: pincodeController,
                      ),
                      textField(
                        hintText: 'Landmark',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: landmarkController,
                      ),
                      textField(
                        hintText: 'Address',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 8,
                        controller: addressController,
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
                          },
                        ),
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
      IconData? icon,
      required TextInputType inputType,
      required int maxLines,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: ThemeColor.primaryColor,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColor.primaryColor,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeColor.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeColor.primaryColor,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: ThemeColor.primaryShade50,
          filled: true,
        ),
      ),
    );
  }

  // Store user data to DB
  // void storeData() async {
  //   final ap = Provider.of<AuthProvider>(context, listen: false);
  //   UserModel userModel = UserModel(
  //     firstName: firstNameController.text,
  //     lastName: lastNameController.text,
  //     email: emailController.text,
  //     uid: ap.uid,
  //     phoneNumber: ap.phoneNumber,
  //     state: stateController.text,
  //     district: districtController.text,
  //     taluk: talukController.text,
  //     area: areaController.text,
  //     pincode: pincodeController.text,
  //     landmark: landmarkController.text,
  //     address: addressController.text,
  //   );
  //   ap.saveUserDataToFireBase(
  //       context: context,
  //       userModel: userModel,
  //       onSuccess: () {
  //         ap.saveUserDataToSP().then(
  //               (value) => ap.setSignIn().then(
  //                     (value) => Navigator.pushAndRemoveUntil(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => const CategoriesScreen(),
  //                         ),
  //                         (route) => false),
  //                   ),
  //             );
  //       });
  // }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      uid: ap.uid,
      phoneNumber: ap.phoneNumber,
      state: stateController.text,
      district: districtController.text,
      taluk: talukController.text,
      area: areaController.text,
      pincode: pincodeController.text,
      landmark: landmarkController.text,
      address: addressController.text,
    );
    ap.registerUser(context, userModel).then(
          (value) => ap.setSignIn().then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                    (route) => false),
              ),
        );
  }
}
