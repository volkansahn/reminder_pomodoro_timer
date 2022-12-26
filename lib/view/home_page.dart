import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';
import 'package:reminder_pomodoro/services/notifications_service.dart';
import 'package:reminder_pomodoro/services/theme_services.dart';
import 'package:reminder_pomodoro/view/add_task_page.dart';
import 'package:reminder_pomodoro/view/add_water_reminder.dart';
import 'package:reminder_pomodoro/view/widgets/button.dart';
import 'package:reminder_pomodoro/view/widgets/reminder_tile.dart';

import '../controller/reminder_controller.dart';
import '../models/reminder_model.dart';
import '../models/water_reminder_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();
  final _reminderController = Get.put(ReminderController());
  var isWaterReminderAdded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init notification plugin
    notifyHelper = NotifyHelper();
    //init notification
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();

    //WaterReminder waterReminder = _reminderController.waterReminderList[1];
    /*
    if (waterReminder != null) {
      isWaterReminderAdded = true;
    }
    print(isWaterReminderAdded);
    print(waterReminder.goal);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(context),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addBar(),
          _addDateBar(),
          _addWaterReminder(),
          SizedBox(height: 10),
          _showReminders()
        ],
      ),
    );
  }

  _showReminders() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _reminderController.reminderList.length,
            itemBuilder: (_, index) {
              Reminder reminder = _reminderController.reminderList[index];
              if (reminder.repeat == 'Daily') {
                DateTime date = DateFormat.jm().parse(reminder.time.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    reminder);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            print("Tapped");
                          },
                          child: ReminderTile(
                              _reminderController.reminderList[index]),
                        ),
                      ]),
                    ),
                  ),
                );
              }
              if (reminder.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            print("Tapped");
                          },
                          child: ReminderTile(
                              _reminderController.reminderList[index]),
                        ),
                      ]),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }

  Container _addWaterReminder() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Builder(
        builder: (context) {
          return isWaterReminderAdded
              ? Container(
                  color: Colors.amber,
                  child: Text(""),
                )
              : Container(
                  color: Colors.amber,
                  child: GestureDetector(
                    onTap: () => Get.to(AddWaterReminder()),
                    child: Text(
                      "Add Water Reminder",
                      style: headingStyle,
                    ),
                  ),
                );
        },
      ),
    );
  }

  Container _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.amber,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  Container _addBar() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                )
              ],
            ),
          ),
          myButton(
              label: "+ Add",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _reminderController.getReminders();
              }),
        ],
      ),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        GestureDetector(
          child: Icon(
            Icons.add,
            size: 40.0,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onTap: () {
            ThemeServices().switchTheme();
            notifyHelper.displayNotification(
                title: "Theme Change",
                body: Get.isDarkMode
                    ? "Light Theme Loaded"
                    : "Dark Theme Loaded");
            //notifyHelper.scheduledNotification();
          },
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
