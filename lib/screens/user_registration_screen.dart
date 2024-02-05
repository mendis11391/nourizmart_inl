import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/model/user_register_model.dart';
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
  final houseNoController = TextEditingController();
  final streetController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final talukController = TextEditingController();
  final areaController = TextEditingController();
  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    houseNoController.dispose();
    streetController.dispose();
    stateController.dispose();
    districtController.dispose();
    talukController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    landmarkController.dispose();
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
                // padding:
                //     const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Container(
                    // color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Contact Details',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Address Details',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 10,
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
                                  hintText: 'State',
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: stateController,
                                  suffixIcon: Icons.keyboard_arrow_down),
                              textField(
                                  hintText: 'District',
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: districtController,
                                  suffixIcon: Icons.keyboard_arrow_down),
                              textField(
                                  hintText: 'Pincode',
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: pincodeController,
                                  suffixIcon: Icons.keyboard_arrow_down),
                              textField(
                                  hintText: 'Area',
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: areaController,
                                  suffixIcon: Icons.keyboard_arrow_down),
                              textField(
                                hintText: 'Landmark',
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: landmarkController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
      required TextEditingController controller,
      IconData? suffixIcon}) {
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
          suffixIcon: suffixIcon != null
              ? Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeColor.primaryColor.withOpacity(0.1),
                  ),
                  child: Icon(
                    suffixIcon,
                    size: 20,
                    color: ThemeColor.primaryColor,
                  ),
                )
              : null,
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

    UserRegisterModel userRegisterModel = UserRegisterModel(
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
    ap.registerUser(context, userRegisterModel).then(
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
