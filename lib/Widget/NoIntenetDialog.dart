import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class NoInternetClass extends StatelessWidget {
  const NoInternetClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
            Text("NO INTERNet")
        ],
      ),
    );
  }
}

