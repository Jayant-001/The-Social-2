import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Filter Page",
      // home: FilterChipDisplay(),
    );
  }
}