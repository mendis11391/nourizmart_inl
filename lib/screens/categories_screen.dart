import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
        title: const Text('Product'),
        actions: [
          IconButton(
            onPressed: signout,
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: userData != null
          ? Text('Welcome, ${userData?.name}')
          : const CircularProgressIndicator(),
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
