import 'dart:convert';

import 'package:http/http.dart' as myHttp;
import 'package:http/http.dart';

import 'Posts.dart';

class HttpConnection {
  String path = "https://jsonplaceholder.typicode.com";

  Future<List<Posts>> getData() async {
    Uri uri = Uri.parse("$path/posts");
    Response respon = await myHttp.get(uri);
    List<Posts> postlist = [];
    if (respon.statusCode == 200) {
      List body = jsonDecode(respon.body);
      for (int i = 0; i < body.length; i++) {
        Posts post = Posts.fromJson(body[i]);
        postlist.add(post);
      }
      return postlist;
    } else {
      throw "error";
    }
  }

  Future<Posts> createPost(String title, String body) async {
    Uri uri = Uri.parse("$path/posts");
    Response response = await myHttp.post(uri,
        headers: {"Content-Type": "application/json ; charset=utf-8"},
        body: jsonEncode({"title": title, "body": body}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      Map<dynamic, dynamic> map = jsonDecode(response.body);
      Posts posts = Posts.fromJson(map);
      return posts;
    } else {
      throw "error";
    }
  }

  Future<Posts> updataPost(int id, String title, String body) async {
    Uri uri = Uri.parse("$path/posts/$id");
    Response response = await myHttp.put(uri,
        headers: {"Content-Type": "application/json ; charset=utf-8"},
        body: jsonEncode({"id": id, "title": title, "body": body}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> map = jsonDecode(response.body);
      Posts posts = Posts.fromJson(map);
      return posts;
    } else {
      throw "error";
    }
  }

  Future<String> deletePost(int id) async {
    Uri uri = Uri.parse("$path/posts/$id");
    Response response = await myHttp.delete(
      uri,
      headers: {"Content-Type": "application/json ; charset=utf-8"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return "deleted successfully";
    } else {
      return "error";
    }
  }
}
