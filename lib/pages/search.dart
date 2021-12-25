import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              heightFactor: 10,
              child: Text("On Search", style: TextStyle(fontSize: 40)))),
      backgroundColor: Colors.white,
    );
  }
}
