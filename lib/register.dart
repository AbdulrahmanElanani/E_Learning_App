import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final ImagePicker picker = ImagePicker();

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
              SizedBox(
                height: 10,
              ),
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
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple[50]),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
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
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple[50]),
                child: TextField(
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
                  const SizedBox(
                    width: 120,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary.withOpacity(.8)),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
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
    );
  }
}
