import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            SizedBox(
              width: 20,
            ),
            Text("Date"),
          ],
        ),
        actions: [
          Icon(Icons.add),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Theme Data",
            style: TextStyle(
              fontSize: 38.0,
            ),
          ),
        ],
      ),
    );
  }
}
