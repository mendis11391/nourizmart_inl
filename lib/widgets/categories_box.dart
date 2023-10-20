import "package:flutter/material.dart";
import 'package:nourish_mart/screens/vegetables_list_Screen.dart';

class CategoriesBox extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final double width;
  final double height;
  final String widgetName;

  const CategoriesBox(
      {super.key,
      required this.categoryName,
      required this.imagePath,
      required this.width,
      required this.height,
      required this.widgetName});

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Image.asset(
    //         imagePath,
    //         width: width,
    //       ),
    //       TextButton(
    //         style: TextButton.styleFrom(
    //           foregroundColor: Colors.purple,
    //         ),
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => CategoriesScreen()),
    //           );
    //         },
    //         child: Text(categoryName),
    //       )
    //     ],
    //   ),
    // );
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VegetablesListScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          imagePath,
          width: width,
        ),
      ),
    );
  }
}
