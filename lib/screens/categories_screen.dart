import 'package:flutter/material.dart';
import 'package:nourish_mart/model/user_model.dart';
import 'package:nourish_mart/model/user_register_model.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/utils/theme.dart';
import 'package:nourish_mart/widgets/categories_box.dart';
import 'package:nourish_mart/widgets/header_options_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  UserRegisterModel? userData;
  List allCategories = [
    [
      "Vegitables",
      "assets/images/categories/vegitables_sm.png",
      150.0,
      200.0,
      'categories'
    ],
    [
      "Milk",
      "assets/images/categories/milk_pack_sm.png",
      150.0,
      100.0,
      'categories'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.primaryColor,
        title: Text("Categories"),
        actions: [
          HeaderOptionsDropdown(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
            child: Text(
              "Welcome, ${userData?.firstName} ${userData?.lastName}",
              style: TextStyle(fontSize: 16),
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
                  padding: const EdgeInsets.only(top: 8.0),
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
    await ap.getUserData(uid!).then((value) => {
          setState(() {
            this.userData = value;
            ap.saveUserDataToStProc(value);
          })
        });
  }
}
