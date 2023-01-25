import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';
import 'package:reminder_pomodoro/view/widgets/button.dart';
import 'package:reminder_pomodoro/view/widgets/circular_drop_down.dart';
import 'package:reminder_pomodoro/view/widgets/input_field.dart';

import '../controller/reminder_controller.dart';
import '../models/reminder_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final ReminderController _reminderController = Get.put(ReminderController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reminderTextController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _userPickedDate = DateTime.now();
  TimeOfDay _userPickedTime = TimeOfDay.now();
  String _reminderTime = DateFormat.jm().format(DateTime.now());
  String _remindBeforeTime = "None";
  String _repeatTime = "None";
  int intervalTime = 0;
  bool isRemindBefore = false;
  bool isRepeat = false;
  Color mycolor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _customAppBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Reminder",
                style: headingStyle,
              ),
              InputField(
                isEditable: true,
                title: "Title",
                hint: "Add Title to Reminder",
                controller: _titleController,
              ),
              InputField(
                  isEditable: true,
                  title: "Reminder",
                  hint: "Add Reminder",
                  controller: _reminderTextController),
              InputField(
                isEditable: false,
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
                isEditable: false,
                onTap: () {
                  _getTimeFromUser();
                },
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
                      Text(
                        "Remind Before",
                        style: titleStyle,
                      ),
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
                    Text(
                      "Repeat",
                      style: titleStyle,
                    ),
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
                        onTap: () {
                          setState(() {
                            _repeatTime = "None";
                          });
                        },
                        child: Text("None"),
                      ),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _repeatTime = "Every Day";
                          });
                        },
                        child: Text("Every Day"),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _repeatTime = "Every Week";
                          });
                        },
                        child: Text("Every Week"),
                      ),
                      value: 7,
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _repeatTime = "Every Month";
                          });
                        },
                        child: Text("Every Month"),
                      ),
                      value: 30,
                    ),
                    DropdownMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _repeatTime = "Every Year";
                          });
                        },
                        child: Text("Every Year"),
                      ),
                      value: 365,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      intervalTime = value;
                    });
                  },
                  hintText: _repeatTime,
                ),
              ],
              InputField(
                isEditable: true,
                title: "Label",
                hint: "Add Label",
                controller: _labelController,
                widget: IconButton(
                  icon: CircleAvatar(radius: 12, backgroundColor: mycolor),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: mycolor, //default color
                                onColorChanged: (Color color) {
                                  //on color picked
                                  setState(() {
                                    mycolor = color;
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('DONE'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); //dismiss the color picker
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              myButton(
                color: Colors.blue,
                label: "Add Reminder",
                onTap: () {
                  _addRemindertoDB();
                },
                buttonWidth: MediaQuery.of(context).size.width,
              ),
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
        _userPickedDate = _pickedDate;
        _selectedDate = _pickedDate;
      });
    }
  }

  _getTimeFromUser() async {
    var _pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_pickedTime != null) {
      setState(() {
        _userPickedTime = _pickedTime;
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

  _addRemindertoDB() async {
    final _selectedDt = DateTime(_userPickedDate.year, _userPickedDate.month,
        _userPickedDate.day, _userPickedTime.hour, _userPickedTime.minute);
    final _format = new DateFormat('yyyy-MM-dd').add_jm();
    var a = _format.format(_selectedDt);
    await _reminderController.addReminder(
      reminder: Reminder(
        title: _titleController.text,
        reminder: _reminderTextController.text,
        date: _format.format(_selectedDt),
        remindBefore: _remindBeforeTime,
        interval: intervalTime,
        label: _labelController.text,
        color: mycolor.value,
        isReminded: 0,
      ),
    );
    Get.back();
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
