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
    String drinkedWater = widget.waterReminder!.totalDrink!.toStringAsFixed(0);
    String goalValue = widget.waterReminder!.goal!.toStringAsFixed(0);

    return Scaffold(
      appBar: _customAppBar(context),
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              _circleIndicator(context, drinkedWater, goalValue),
              SizedBox(
                height: 30,
              ),
              _waterStatus(drinkedWater, goalValue),
              SizedBox(
                height: 30,
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

  Container _circleIndicator(
      BuildContext context, String drinkedWater, String goalValue) {
    double circleRadius = MediaQuery.of(context).size.width - 50;
    double percent =
        widget.waterReminder!.totalDrink! / widget.waterReminder!.goal!;
    if (percent > 1) {
      percent = 1;
    }
    return Container(
      child: CircularPercentIndicator(
        radius: circleRadius / 2,
        lineWidth: 25.0,
        percent: percent,
        center: new Text(
          "$drinkedWater / $goalValue",
          style: titleStyle,
        ),
        progressColor: Colors.blue,
      ),
    );
  }

  Container _waterStatus(String drinkedWater, String goalValue) {
    var remaining = int.parse('$goalValue') - int.parse('$drinkedWater');
    var balance =
        ((double.parse('$drinkedWater') / double.parse('$goalValue')) * 100)
            .toStringAsFixed(2);
    if ((double.parse('$drinkedWater') / double.parse('$goalValue')) * 100 >
        100) {
      balance = "100";
    }
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  "Target",
                  style: titleStyle,
                ),
                Text(
                  goalValue,
                  style: titleStyle,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "Remaining",
                  style: titleStyle,
                ),
                Text(
                  "$remaining ml",
                  style: titleStyle,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "Balance",
                  style: titleStyle,
                ),
                Text(
                  "$balance %",
                  style: titleStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _addButton() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        children: [
          Container(
            child: Column(children: [
              GroupButton(
                isRadio: true,
                onSelected: (value, index, isSelected) {
                  setState(() {
                    addAmount = double.parse(value);
                  });
                },
                buttons: ["200", "300", "500", "1000"],
                options: GroupButtonOptions(
                  selectedTextStyle: subHeadingStyle,
                  unselectedTextStyle: subHeadingStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              addAmount = addAmount - 10;
                            });
                          },
                          child: Center(
                              child: Text(
                            "-",
                            style: titleStyle,
                          ))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$addAmount",
                      style: titleStyle,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "ml",
                      style: titleStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.green,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              addAmount += 10;
                            });
                          },
                          child: Center(
                              child: Text(
                            "+",
                            style: titleStyle,
                          ))),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
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
