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
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final houseNoController = TextEditingController();
  final streetController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final areaController = TextEditingController();
  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    houseNoController.dispose();
    streetController.dispose();
    stateController.dispose();
    districtController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    landmarkController.dispose();
    super.dispose();
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
                        hintText: 'House No',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: houseNoController,
                      ),
                      textField(
                        hintText: 'Street',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: streetController,
                      ),
                      textField(
                          hintText: 'state',
                          icon: Icons.account_circle,
                          inputType: TextInputType.name,
                          maxLines: 1,
                          controller: stateController,
                          suffixIcon: Icons.keyboard_arrow_down),
                      textField(
                        hintText: 'district',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: districtController,
                      ),
                      textField(
                        hintText: 'pincode',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: pincodeController,
                      ),
                      textField(
                        hintText: 'area',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: areaController,
                      ),
                      textField(
                        hintText: 'landmark',
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: landmarkController,
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
      required TextEditingController controller,
      IconData? suffixIcon}) {
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
          suffixIcon: suffixIcon != null
              ? Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple,
                  ),
                  child: Icon(
                    suffixIcon,
                    size: 20,
                    color: Colors.white,
                  ),
                )
              : null,
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
        firebaseId: ap.firebaseId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: ap.mobile,
        email: emailController.text,
        houseNo: houseNoController.text,
        street: streetController.text,
        stateId: stateController.text,
        districtId: districtController.text,
        pincodeId: pincodeController.text,
        areaId: areaController.text,
        landmark: landmarkController.text,
        isActive: 'Y',
        createdBy: 'User');
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
