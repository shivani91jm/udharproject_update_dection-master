import 'package:flutter/material.dart';
class AddShiftActivityPage extends StatefulWidget {
  const AddShiftActivityPage({Key? key}) : super(key: key);

  @override
  State<AddShiftActivityPage> createState() => _AddShiftActivityPageState();
}

class _AddShiftActivityPageState extends State<AddShiftActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(),
      body:  SingleChildScrollView(),
    );
  }
}
