import 'dart:developer';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String? email;

  String? pass;

  void submitOnPressed() {
    email = _emailController.text.trim();
    pass = _passwordController.text.trim();
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    if (email!.isEmpty) {
      log("email Field is empty");
    } else if (pass!.isEmpty) {
      log("password Field is empty");
    } else if (!emailRegex.hasMatch(email!)) {
      log("Email address isn't valid!");
    } else {}
  }

  bool visible = true;

  void showPassword() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 40, color: Color.fromARGB(255, 204, 175, 191)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.purple[50]),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  border: InputBorder.none,
                  labelText: 'Enter you email address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.purple[50]),
              child: TextFormField(
                obscureText: visible,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: IconButton(
                      onPressed: showPassword,
                      icon: Icon(
                        visible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.deepPurple,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary.withOpacity(.8),
                    ),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/HomeScreen");
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed("/RegisterScreen");
                  },
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
