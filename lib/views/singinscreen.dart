// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/forgotpasswordscreen.dart';
import 'package:note_app/views/homescreen.dart';
import 'package:note_app/views/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Login Screen"),
        // actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300.0,
                child: Lottie.asset("assets/animation_lnkbeh11.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginPasswordController.text.trim();

                  try {
                    final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: loginEmail, password: loginPassword))
                        .user;
                    if (firebaseUser != null) {
                      Get.to(() => HomeScreen());
                    } else {
                      print("Check Email & Password");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ForgotPasswordScreen());
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Forgot Password"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Don't have an account! SingUp"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
