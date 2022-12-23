import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddWaterReminder extends StatefulWidget {
  const AddWaterReminder({super.key});

  @override
  State<AddWaterReminder> createState() => _AddWaterReminderState();
}

class _AddWaterReminderState extends State<AddWaterReminder> {
  final _reminderController = Get.put(ReminderController());

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _dailyGoal(),
            SizedBox(height: 10),
            _remindPeriod(),
            SizedBox(height: 10),
            _remindPeriod(),
            SizedBox(height: 10),
            _addButton(),
          ],
        ),
      ),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      title: const Text('Water Reminder'),
    );
  }

  Container _dailyGoal() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Column(
        children:[
          Text("Target"),
          Row(children: [
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your daily goal',
              ),
              keyboardType: TextInputType.numberWithOptions(),
              ),
              Text("ml/day"),
            ],
          ),
        ]
      ),
    );
  }
  
  Container _remindPeriod() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Column(
        children:[
          Text("Remind Every"),
          GroupButton(
            isRadio: true,
            onSelected: (index, isSelected) {
              print('$index is selected');
            }
            buttons: ["15 min", "30 min", "1 hour"],
            controller: GroupButtonController(selectedIndex: 0),
          ),
        ]
      ),
    );
  }
  
  Container _addButton() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: ElevatedButton(
            style: style,
            onPressed: () {print("Added");},
            child: const Text('Enabled'),
          ),
    );
  }
  
}
