import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../controller/reminder_controller.dart';
import '../models/water_reminder_model.dart';

class AddWater extends StatefulWidget {
  final WaterReminder? waterReminder;

  const AddWater(this.waterReminder);

  @override
  State<AddWater> createState() => _AddWaterState();
}

class _AddWaterState extends State<AddWater> {
  final ReminderController _reminderController = Get.put(ReminderController());
  double addAmount = 0;
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
              _circleIndicator(context),
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

  Container _circleIndicator(BuildContext context) {
    return Container(
      child: CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 5.0,
        percent:
            (widget.waterReminder!.totalDrink! / widget.waterReminder!.goal!),
        center: new Text("&(waterReminder.totalDrink / waterReminder.goal)"),
        progressColor: Colors.blue,
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
          Container(
            child: Column(children: [
              GroupButton(
                isRadio: true,
                onSelected: (value, index, isSelected) {
                  print(value);
                },
                buttons: ["200", "300", "500", "1000"],
                controller: GroupButtonController(selectedIndex: 0),
                options: GroupButtonOptions(
                  selectedTextStyle: subHeadingStyle,
                  unselectedTextStyle: subHeadingStyle,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                      child: Text("-"),
                      onTap: (() {
                        setState:
                        (() {
                          addAmount -= 10;
                        });
                      })),
                  Text('&addAmount'),
                  GestureDetector(
                      child: Text("-"),
                      onTap: (() {
                        setState:
                        (() {
                          addAmount += 10;
                        });
                      })),
                  Text("ml"),
                ],
              ),
            ]),
          ),
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              var totalAmount = widget.waterReminder!.totalDrink!;
              totalAmount += addAmount;
              _reminderController.addDrink(
                  widget.waterReminder!.id!, totalAmount);
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
