import 'package:flutter/material.dart';
import 'package:pizza/routes/Welcome/welcome.dart';
import 'package:pizza/routes/home.dart';
import 'package:pizza/server/services/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return user == null ? Welcome() : Home();
  }
}
