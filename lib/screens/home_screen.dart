import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userData = '';
  UserModel? userDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: signout,
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(child: Text('${userDataModel!.name}')),
    );
  }

  @override
  void initState() {
    super.initState();
    userDataModel = UserModel(name: '', email: '', uid: '', phoneNumber: '');
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // userData = (prefs.getString('user_model') ?? '');
      userData = prefs.getString('user_model');
      userDataModel = UserModel.fromMap(jsonDecode(userData.toString()));
    });
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
