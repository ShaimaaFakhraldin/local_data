import 'package:flutter/material.dart';
import 'package:local_data/online/Posts.dart';

import 'http_clint.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  HttpConnection httpConnection = HttpConnection();
  String sTitle = "";
  String sBody = "";
  Posts? post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add post"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
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
                    post = await httpConnection.createPost(sTitle, sBody);
                    print(post!.toJson());
                    setState(() {});
                  },
                  child: Text("Send")),
              SizedBox(
                height: 50,
              ),
              post != null ? showDataAdded(post!) : Container(),
            ],
          ),
        ));
  }

  showDataAdded(Posts posts) {
    return ListTile(
      title: Text("${posts.title}"),
      subtitle: Text("${posts.body}"),
      leading: Text("${posts.id}"),
    );
  }
}
