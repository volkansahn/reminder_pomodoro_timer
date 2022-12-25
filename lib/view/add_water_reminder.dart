import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';

class AddWaterReminder extends StatefulWidget {
  const AddWaterReminder({super.key});

  @override
  State<AddWaterReminder> createState() => _AddWaterReminderState();
}

class _AddWaterReminderState extends State<AddWaterReminder> {
  @override
  void initState() {
    // TODO: implement initState
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
              _dailyGoal(),
              SizedBox(
                height: 50,
              ),
              _remindPeriod(),
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
        "Water Reminder",
        style: TextStyle(color: Colors.amber),
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

  Container _dailyGoal() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  "Daily Goal",
                  style: headingStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your daily goal',
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "ml/day",
                      style: subHeadingStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _remindPeriod() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Column(
        children: [
          Text(
            "Remind Every",
            style: headingStyle,
          ),
          SizedBox(
            height: 20,
          ),
          GroupButton(
            isRadio: true,
            onSelected: (value, index, isSelected) {
              print("$index is selected");
            },
            buttons: ["15 min", "30 min", "1 hour"],
            controller: GroupButtonController(selectedIndex: 0),
            options: GroupButtonOptions(
              selectedTextStyle: subHeadingStyle,
              unselectedTextStyle: subHeadingStyle,
            ),
          ),
        ],
      ),
    );
  }

  Container _addButton() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {
          print("Added");
        },
        child: const Text('Add',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
