import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';

class AddWater extends StatefulWidget {
  const AddWater({super.key});

  @override
  State<AddWater> createState() => _AddWaterState();
}

class _AddWaterState extends State<AddWater> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(context),
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              _circleIndicator(),
              SizedBox(
                height: 50,
              ),
              _waterStatus(),
              SizedBox(
                height: 50,
              ),
              _addButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      title: Text(
        "Add Water",
        style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Container _circleIndicator() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }

  Container _waterStatus() {
    return Container(
      child: Row(
        children: [
          Container(
            child: Column(
              children: [
                Text("Target"),
                Text("2400 ml"),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Remaining"),
                Text("240 ml"),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Balance"),
                Text("90 %"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _addButton() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Column(
        children: [
          Container(),
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              print("Added");
            },
            child: const Text(
              'Add',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
