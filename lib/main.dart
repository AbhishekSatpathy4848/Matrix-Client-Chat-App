// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'features/login_registration/pages/page_1.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Login(),
  ));
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
