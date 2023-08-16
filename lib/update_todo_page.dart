import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateToDo extends StatefulWidget {
  final String title;
  final String description;
  final String todoDocId;
  const UpdateToDo(
      {super.key,
      required this.title,
      required this.description,
      required this.todoDocId});

  @override
  State<UpdateToDo> createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  User? currUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update TODO"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "enter TODO title",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "enter TODO description",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  if (currUser != null &&
                      titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(currUser!.uid)
                        .collection("todos")
                        .doc(widget.todoDocId)
                        .update(
                      {
                        'title': titleController.text,
                        'description': descriptionController.text,
                      },
                    );

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Title and Description cannot be empty"),
                      ),
                    );
                  }
                },
                child: const Text("Update TODO"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
