import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_1st/login.dart';
import 'package:project_1st/shared/snackBar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final ImagePicker picker = ImagePicker();
  bool isVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool isPassword8char = false;
  bool isPasswordHas1number = false;
  bool isPasswordHasUppercase = false;
  bool isPasswordHasLowercase = false;
  bool isPasswordHasSpecialCharacter = false;

  register() async {
    try {
      setState(() {
        isLoading = true;
      });
      final credintial =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!mounted) return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exits for this email');
      } else {
        showSnackBar(context, 'Error, please try again later!');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  onPasswordChanged(String password) {
    isPassword8char = false;
    isPasswordHas1number = false;
    isPasswordHasUppercase = false;
    isPasswordHasLowercase = false;
    isPasswordHasSpecialCharacter = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8char = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1number = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        isPasswordHasUppercase = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        isPasswordHasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        isPasswordHasSpecialCharacter = true;
      }
    });
  }


  File? attachImage;

// Pick an image.
  fetchImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      attachImage = File(image.path);
    });
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create an account",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundImage: attachImage == null
                                ? const AssetImage("assets/images/pic.png")
                                : FileImage(attachImage!)),
                        Positioned(
                          child: IconButton(
                              onPressed: fetchImage,
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.lightBlueAccent,
                              )),
                        )
                      ],
                    ),
                    const Text(
                      'Select Your photo',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //Name
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[50]),
                  child: const TextField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.blueGrey,
                        )),
                  ),
                ),
                //Email
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[50]),
                  child: TextFormField(
                    validator: (value) {
                      return !value!.contains(
                        RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                      )
                          ? "Enter a valid email"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blueGrey,
                        )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[50]),
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.blueGrey,
                        )),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.purple[50]),
                        child: const TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: 'Age',
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.blueGrey,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                //Password
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[50]),
                  child: TextFormField(
                    onChanged: (value) {
                      onPasswordChanged(value);
                    },
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: isVisible ? true : false,
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
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: isPassword8char
                            ? Border.all(color: Colors.green)
                            : Border.all(color: Colors.grey.shade400),
                        shape: BoxShape.circle,
                        color: isPassword8char ? Colors.green : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text('At least 8 characters'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: isPasswordHas1number
                            ? Border.all(color: Colors.green)
                            : Border.all(color: Colors.grey.shade400),
                        shape: BoxShape.circle,
                        color: isPasswordHas1number ? Colors.green : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text('At least 1 number'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: isPasswordHasUppercase
                            ? Border.all(color: Colors.green)
                            : Border.all(color: Colors.grey.shade400),
                        shape: BoxShape.circle,
                        color:
                            isPasswordHasUppercase ? Colors.green : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text('Has Uppercase'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: isPasswordHasLowercase
                            ? Border.all(color: Colors.green)
                            : Border.all(color: Colors.grey.shade400),
                        shape: BoxShape.circle,
                        color:
                            isPasswordHasLowercase ? Colors.green : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text('Has Lowercase'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: isPasswordHasSpecialCharacter
                            ? Border.all(color: Colors.green)
                            : Border.all(color: Colors.grey.shade400),
                        shape: BoxShape.circle,
                        color: isPasswordHasSpecialCharacter
                            ? Colors.green
                            : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    const Text('Has special character '),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 33,
                ),
                //Register
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await register();
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      } else {
                        showSnackBar(context, 'Error');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary.withOpacity(.8)),
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account?',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("/LoginScreen");
                        },
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
