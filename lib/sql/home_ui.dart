import 'package:flutter/material.dart';

import '../main.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeUi> createState() => _MyHomeUiState();
}

class _MyHomeUiState extends State<HomeUi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> row = {
                    "name": "shaimaa",
                    "content": "developer",
                    "Description": " flutter developer",
                  };
                  await database.insert(row);
                },
                child: Text("add ")),
            ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> list = await database.query();
                  print(list);
                },
                child: Text("get all Data ")),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> row = {
                    "id": 1,
                    "name": "ahmed",
                    "content": "ui ux",
                    "Description": "designer",
                  };
                  await database.update(row);
                },
                child: Text("update ")),
            ElevatedButton(
                onPressed: () async {
                  await database.delete(3);
                },
                child: Text("delete")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
