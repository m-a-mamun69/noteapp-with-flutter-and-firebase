// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_app/views/homescreen.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Notes"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: noteController,
                  maxLines: null,
                  decoration: InputDecoration(hintText: "Add Note"),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.trim();
                  if (note != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                        "createdAt": DateTime.now(),
                        "note": note,
                        "userId": userId?.uid,
                      }).then((value) => {
                                Get.offAll(() => HomeScreen()),
                              });
                    } catch (e) {
                      print("Error $e");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15.0),
                    textStyle: TextStyle(
                      fontSize: 18,
                    )),
                child: Text("Add Note"),
              )
            ],
          )),
    );
  }
}
