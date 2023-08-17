import 'package:crud_operations/services/api/api_fetch.dart';
import 'package:crud_operations/services/models/models.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<PostResponse> posts = [];
  @override
  void initState() {
    getPosts();
    super.initState();
  }

  getPosts() async {
    final postTemp = await fetchPost();
    setState(() {
      posts = postTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Of Posts"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue.shade200,
                  ),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(
                    6,
                  )),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts[index].body,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
