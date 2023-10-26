import 'package:flutter/material.dart';
import 'package:nourish_mart/provider/auth_provider.dart';
import 'package:nourish_mart/screens/register_screen.dart';
import 'package:nourish_mart/utils/theme.dart';
import 'package:provider/provider.dart';

class HeaderOptionsDropdown extends StatelessWidget {
  HeaderOptionsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(5),
        ),
        onPressed: () {
          double height = MediaQuery.of(context).size.height;
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                height: height,
                color: ThemeColor.primaryShade100,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: ThemeColor.whiteColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView(
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeColor.primaryColor,
                                ),
                                onPressed: () => {},
                                child: const Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(Icons.verified_user),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Profile")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeColor.primaryColor,
                                ),
                                onPressed: signout,
                                child: const Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(Icons.logout),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Logout")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.menu),
      ),
    );
  }
}
