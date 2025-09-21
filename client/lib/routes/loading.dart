import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEF1C26),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/loadingimage.png",
                height: 215,
                fit: BoxFit.cover,
              ),
            ),
            SpinKitFadingCircle(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
