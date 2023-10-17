// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations

// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homescreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
        child: Column(children: [
          TextFormField(
            controller: noteController
              ..text = "${Get.arguments['note'].toString()}",
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("notes")
                    .doc(Get.arguments['docId'].toString())
                    .update(
                  {
                    'note': noteController.text.trim(),
                  },
                ).then((value) => {
                          // Needed For Back to Screen.
                          Get.offAll(() => HomeScreen()),
                        });
              },
              child: Text("Update"))
        ]),
      ),
    );
  }
}
