import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/widgets/categories_box.dart';
import 'package:nourish_mart/widgets/header_options_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userData;
  List allCategories = [
    [
      "Vegitables",
      "assets/images/categories/vegitables.jpg",
      250.0,
      200.0,
      'categories'
    ],
    [
      "Milk",
      "assets/images/categories/milk_pack.png",
      150.0,
      100.0,
      'categories'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('${userData?.name}'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
            child: Text(
              "CATEGORIES",
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: allCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoriesBox(
                    categoryName: allCategories[index][0],
                    imagePath: allCategories[index][1],
                    width: allCategories[index][2],
                    height: allCategories[index][3],
                    widgetName: allCategories[index][4],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('uid');
    final userData = await ap.getUserDataFromFirestore(uid!);
    setState(() {
      this.userData = userData;
      ap.saveUserDataToStProc(userData);
    });
  }
}
