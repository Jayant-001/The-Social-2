import 'dart:ui';

import 'package:flutter/material.dart';

class message extends StatefulWidget {
  const message({Key? key}) : super(key: key);

  @override
  _messageState createState() => _messageState();
}

class _messageState extends State<message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              heightFactor: 10,
              child: Text(
                "On Message",
                style: TextStyle(fontSize: 40),
              ))),
      backgroundColor: Colors.white,
    );
  }
}
