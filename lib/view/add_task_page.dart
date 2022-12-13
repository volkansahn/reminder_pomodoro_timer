import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';
import 'package:reminder_pomodoro/view/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _reminderTime = DateFormat.jm().format(DateTime.now());
  String _remindBeforeTime = "None";
  String _repeatTime = "None";
  bool isRemindBefore = false;
  bool isRepeat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _customAppBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Reminder",
                style: headingStyle,
              ),
              InputField(title: "Title", hint: "Add Title to Reminder"),
              InputField(title: "Reminder", hint: "Add Reminder"),
              InputField(
                onTap: (() {
                  _getDateFromUser(context);
                }),
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _getDateFromUser(context);
                  },
                ),
              ),
              InputField(
                title: "Time",
                hint: _reminderTime,
                widget: IconButton(
                  icon: Icon(Icons.access_alarm),
                  onPressed: () {
                    _getTimeFromUser();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Remind Before"),
                      Switch(
                        // This bool value toggles the switch.
                        value: isRemindBefore,
                        activeColor: Colors.green,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            isRemindBefore = value;
                          });
                        },
                      ),
                    ]),
              ),
              if (!isRemindBefore) ...[
                Container(),
              ] else ...[
                CircularDropDownMenu(
                  dropDownMenuItem: [
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("5 min"),
                      ),
                      value: "5 min",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("10 min"),
                      ),
                      value: "10 min",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("15 min"),
                      ),
                      value: "15 min",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("30 min"),
                      ),
                      value: "30 min",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _remindBeforeTime = value;
                    });
                  },
                  hintText: _remindBeforeTime,
                ),
              ],
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Repeat"),
                    Switch(
                      // This bool value toggles the switch.
                      value: isRepeat,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          isRepeat = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (!isRepeat) ...[
                Container(),
              ] else ...[
                CircularDropDownMenu(
                  dropDownMenuItem: [
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("None"),
                      ),
                      value: "None",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("Every Hour"),
                      ),
                      value: "Every Hour",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("Every Week"),
                      ),
                      value: "Every Week",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("Every Month"),
                      ),
                      value: "Every Month",
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text("Every Year"),
                      ),
                      value: "Every Year",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _repeatTime = value;
                    });
                  },
                  hintText: _repeatTime,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUser(BuildContext context) async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2029),
    );

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }

  _getTimeFromUser() async {
    var _pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_pickedTime != null) {
      setState(() {
        _reminderTime = _formatTimeOfDay(_pickedTime);
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }
}

AppBar _customAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.backgroundColor,
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
