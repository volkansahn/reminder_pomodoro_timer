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
import 'package:reminder_pomodoro/view/widgets/add_water_tile.dart';
import 'package:reminder_pomodoro/view/widgets/button.dart';
import 'package:reminder_pomodoro/view/widgets/reminder_tile.dart';

import '../controller/reminder_controller.dart';
import '../models/reminder_model.dart';
import '../models/water_reminder_model.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
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
    _reminderController.getReminders();
    _reminderController.getWaterReminders();
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
          _showWaterReminder(),
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
              final splitted = reminder.date!.split(' ');
              DateTime reminderDt = DateTime.parse(splitted[0]);

              if (reminder.interval == null) {
                if (DateFormat.yMd().format(reminderDt) ==
                    DateFormat.yMd().format(_selectedDate)) {
                  print(reminder);

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
              } else if (reminderDt.compareTo(_selectedDate) < 0) {
                final difference = _selectedDate.difference(reminderDt).inDays;

                for (int i = 0; i < difference; reminder.interval) {
                  reminderDt = reminderDt.add(Duration(days: i));

                  if (DateFormat.yMd().format(reminderDt) ==
                      DateFormat.yMd().format(_selectedDate)) {
                    print(reminder);

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
                }
              } else {
                return Container();
              }
              return Container();
            });
      }),
    );
  }

  _showWaterReminder() {
    _reminderController.getWaterReminders();

    return Obx((() {
      var waterReminderNumber = _reminderController.waterReminderList.length;
      var waterReminderList = _reminderController.waterReminderList;
      if (waterReminderNumber == 0) {
        return _addWaterReminder();
      } else {
        for (int i = 0; i < waterReminderNumber; i++) {
          if (_reminderController.waterReminderList[i].date ==
              (DateFormat.yMd().format(_selectedDate))) {
            return AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        print("Tapped");
                      },
                      child: AddWaterTile(
                          _reminderController.waterReminderList[i]),
                    ),
                  ]),
                ),
              ),
            );
          }
        }
        if (waterReminderList[waterReminderNumber - 1].isValid == 1) {
          _addWaterRemindertoDB(waterReminderList[waterReminderNumber - 1]);
          return AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      print("Tapped");
                    },
                    child: AddWaterTile(_reminderController
                        .waterReminderList[waterReminderNumber - 1]),
                  ),
                ]),
              ),
            ),
          );
        } else {
          return _addWaterReminder();
        }
      }
    }));
  }

  _addWaterRemindertoDB(WaterReminder waterReminder) async {
    await _reminderController.addWaterReminder(
      waterReminder: WaterReminder(
        goal: waterReminder.goal,
        date: DateFormat.yMd().format(_selectedDate),
        remindPeriod: waterReminder.remindPeriod,
        isValid: 1,
        totalDrink: 0,
      ),
    );
    Get.back();
  }

  Container _addWaterReminder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.amber,
      ),
      child: GestureDetector(
        onTap: () async {
          await Get.to(AddWaterReminder());
          _reminderController.getWaterReminders();
        },
        child: Center(
          child: Row(
            children: [
              Text(
                "Add Water Reminder",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.water_drop_rounded,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
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
            },
            buttonWidth: 100,
          ),
        ],
      ),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          'REMINDER',
          style: titleStyle,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        GestureDetector(
          child: Icon(
            Icons.settings,
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
