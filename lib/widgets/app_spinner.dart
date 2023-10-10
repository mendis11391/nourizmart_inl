import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      itemBuilder: (BuildContext context, int index) {
        return const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.purple,
          ),
        );
      },
    );
  }
}
