import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/update_todo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  User? currUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO App"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 250,
            color: Colors.grey.shade200,
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
                            .add(
                          {
                            'title': titleController.text,
                            'description': descriptionController.text
                          },
                        );
                        titleController.clear();
                        descriptionController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Title and Description cannot be empty"),
                          ),
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade200,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currUser!.uid)
                      .collection("todos")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final docs = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: ValueKey(
                              docs[index].id,
                            ),
                            onDismissed: (direction) async {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(currUser!.uid)
                                  .collection("todos")
                                  .doc(docs[index].id)
                                  .delete();
                            },
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateToDo(
                                      title: docs[index]['title'],
                                      description: docs[index]['description'],
                                      todoDocId: docs[index].id,
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                docs[index]['title'],
                              ),
                              subtitle: Text(
                                docs[index]['description'],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
