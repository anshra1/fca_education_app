import 'dart:convert';

import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  run() {
    var data = {'name': 'Ansh Raj', 'age': 21};
    var encodedData = jsonEncode(data) ; // convert map to strng
    print(encodedData);
    print(encodedData.runtimeType);

    var map = jsonDecode(encodedData) as DataMap;
    print(map);
    print(map.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    run();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Container(),
    );
  }
}
