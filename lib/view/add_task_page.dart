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
  String _category = "General";
  int intervalTime = 0;
  bool isRemindBefore = false;
  bool isRepeat = false;
  List<Color> selectedCategoryColors = [Colors.blue[200]!, Colors.blue[400]!];

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
              SizedBox(
                height: 20,
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
                controller: _reminderTextController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
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
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InputField(
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
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Remind Before",
                      style: inputTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButton(
                        value: _remindBeforeTime,
                        items: ["None", "5 Min", "15 Min", "30 Min", "1 Hour"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: inputTextStyle,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _remindBeforeTime = newValue!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Repeat",
                      style: inputTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButton(
                        value: _repeatTime,
                        items: ["None", "Every Day", "Every Week", "Every Year"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: inputTextStyle,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _repeatTime = newValue!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
                          style: inputTitleStyle,
                        ),
                        CircleAvatar(
                            radius: 12,
                            backgroundColor: selectedCategoryColors[1]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButton(
                        value: _category,
                        items: ["General", "Shopping", "Birthday", "Pills"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: inputTextStyle,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _category = newValue!;
                            switch (_category) {
                              case "General":
                                selectedCategoryColors = [
                                  Colors.blue[200]!,
                                  Colors.blue[400]!
                                ];
                                break;
                              case "Shopping":
                                selectedCategoryColors = [
                                  Colors.amber[200]!,
                                  Colors.amber[400]!
                                ];
                                break;
                              case "Birthday":
                                selectedCategoryColors = [
                                  Colors.green[200]!,
                                  Colors.green[400]!
                                ];
                                break;
                              case "Pills":
                                selectedCategoryColors = [
                                  Colors.blueGrey[200]!,
                                  Colors.blueGrey[400]!
                                ];
                                break;
                              default:
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              myButton(
                color: selectedCategoryColors[1],
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
        time: _reminderTime,
        remindBefore: _remindBeforeTime,
        interval: intervalTime,
        label: _labelController.text,
        firstColor: selectedCategoryColors[0].value,
        secondColor: selectedCategoryColors[1].value,
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
