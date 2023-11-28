import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Posts.dart';
import 'add_post.dart';
import 'http_clint.dart';

class MyWallUi extends StatefulWidget {
  const MyWallUi({super.key});

  @override
  State<MyWallUi> createState() => _MyWallUiState();
}

class _MyWallUiState extends State<MyWallUi> {
  HttpConnection _HttpClient = HttpConnection();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My wall"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddPost();
          }));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Posts>>(
        future: _HttpClient.getData(),
        builder: (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext cons, int index) {
                  return ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                  height: 300,
                                  width: 300,
                                  child: Column(
                                    children: [
                                      Text(
                                          "are you sure you want to delete this item"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () async {
                                                String value = await _HttpClient
                                                    .deletePost(snapshot
                                                        .data![index].id!);
                                                Fluttertoast.showToast(
                                                    msg: value,
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              },
                                              child: Text("yes")),
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text("no")),
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          });
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //         content: Container(
                      //           height: 300,
                      //           width: 300,
                      //           child: EditePost(
                      //             posts: snapshot.data![index],
                      //           ),
                      //         ),
                      //       );
                      //     });
                    },
                    title: Text(snapshot.data![index].title!),
                    leading: Text("${snapshot.data![index].id!}"),
                  );
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text("empty"),
            );
          }
        },
      ),
    );
  }
}
