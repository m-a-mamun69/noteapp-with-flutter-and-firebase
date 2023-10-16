// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_types_as_parameter_names, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/createnotescreen.dart';
import 'package:note_app/views/editnotescreen.dart';
import 'package:note_app/views/singinscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => LoginScreen());
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("notes")
                .where("userId", isEqualTo: userId?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Semething Went Worng!");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No Data Found!"));
              }

              if (snapshot != null && snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, Index) {
                    var note = snapshot.data!.docs[Index]['note'];
                    var noteId = snapshot.data!.docs[Index]['userId'];
                    var docId = snapshot.data!.docs[Index].id;
                    return Card(
                      child: ListTile(
                        title: Text(
                          note,
                        ),
                        subtitle: Text(noteId),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => EditNoteScreen(),
                                    arguments: {
                                      'note': note,
                                      'docId': docId,
                                    },
                                  );
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.delete),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateNoteScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
