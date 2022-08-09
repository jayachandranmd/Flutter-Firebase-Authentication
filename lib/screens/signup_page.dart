import 'package:firebase_authentication_demo/methods/auth_methods.dart';
import 'package:firebase_authentication_demo/screens/home_page.dart';
import 'package:firebase_authentication_demo/widgets/text_field_input.dart';

import 'package:flutter/material.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'SignUp',
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFieldInput(
                    textEditingController: _emailController,
                    hintText: 'Enter your email',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter your email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please enter a valid email");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldInput(
                    textEditingController: _userNameController,
                    hintText: 'Enter your username',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return ("Username cannot be empty");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    isPass: true,
                    validate: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              AuthMethods()
                                  .signUpUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      username: _userNameController.text)
                                  .then((value) => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage())));
                            }
                          },
                          child: const Text('Signup'))),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 3),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text('Login',
                            style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline)),
                      )
                    ],
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
