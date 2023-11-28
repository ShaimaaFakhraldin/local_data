import 'package:flutter/material.dart';

import 'Posts.dart';
import 'http_clint.dart';

class EditePost extends StatefulWidget {
  final Posts posts;
  const EditePost({super.key, required this.posts});

  @override
  State<EditePost> createState() => _EditePostState();
}

class _EditePostState extends State<EditePost> {
  HttpConnection httpConnection = HttpConnection();
  String sTitle = "";
  String sBody = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.posts.title,
              decoration: InputDecoration(labelText: "Title"),
              onChanged: (String value) {
                setState(() {
                  sTitle = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.posts.body,
              decoration: InputDecoration(labelText: "body"),
              onChanged: (String value) {
                setState(() {
                  sBody = value;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  Posts post = await httpConnection.updataPost(
                      widget.posts.id!, sTitle, sBody);
                  print(post.toJson());
                  // setState(() {});
                },
                child: Text("Send")),
          ],
        ),
      ),
    );
  }
}
