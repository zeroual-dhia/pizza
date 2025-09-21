import 'package:flutter/material.dart';
import 'package:pizza/routes/Welcome/landing.dart';
import 'package:pizza/routes/Welcome/landing1.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        LandingPage(controller: _controller),
        Landing1(controller: _controller, count: 2, index: 0),
        Landing1(controller: _controller, count: 2, index: 1),
      ],
    );
  }
}
