import 'package:firebase_authentication_demo/methods/auth_methods.dart';
import 'package:firebase_authentication_demo/screens/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          AuthMethods().signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        },
        child: const Text('Logout'),
      )),
    );
  }
}
