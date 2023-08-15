import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  User? currUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Simple TODO"),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 200,
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(hintText: "enter TODO title"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: "enter TODO description"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (currUser != null) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(currUser!.uid)
                                  .collection("todos")
                                  .add(
                                {
                                  'title': titleController.text,
                                  'decription': descriptionController.text,
                                },
                              );
                            }
                          },
                          child: const Text("Save")),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(currUser!.uid)
                          .collection("todos")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(docs[index]['title']),
                                subtitle: Text(docs[index]['decription']),
                              );
                            },
                          );
                        }
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
