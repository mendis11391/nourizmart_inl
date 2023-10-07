import 'package:flutter/material.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
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
    );
  }

  void signout() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signout();
  }
}
