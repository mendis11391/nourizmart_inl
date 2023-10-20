import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/screens/register_screen.dart';
import 'package:nourish_mart/utils/theme.dart';
import 'package:nourish_mart/widgets/app_spinner.dart';
import 'package:nourish_mart/widgets/header_options_dropdown.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class VegetablesListScreen extends StatefulWidget {
  const VegetablesListScreen({super.key});

  @override
  State<VegetablesListScreen> createState() => _VegetablesListScreenState();
}

class _VegetablesListScreenState extends State<VegetablesListScreen> {
  UserModel? userData;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final userData = await ap.getUserDataFromSP();
    setState(() {
      this.userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.primaryColor,
        title: const Text('Product'),
        actions: [
          // IconButton(
          //   onPressed: signout,
          //   icon: const Icon(
          //     Icons.exit_to_app,
          //     color: Colors.white,
          //   ),
          // ),
          HeaderOptionsDropdown(),
        ],
      ),
      body: userData != null
          ? Center(
              child:
                  Text('Welcome,${userData?.firstName} ${userData?.lastName}'),
            )
          : const AppSpinner(),
    );
  }

  void signout() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
        (route) => false);
  }
}
