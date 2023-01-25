import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';

import '../services/notifications_service.dart';
import '../services/theme_services.dart';
import 'add_timer.dart';

class TimerHome extends StatefulWidget {
  const TimerHome({super.key});

  @override
  State<TimerHome> createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init notification plugin
    notifyHelper = NotifyHelper();
    //init notification
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(context),
      body: Column(
        children: [
          _addTimer(
            AddTimer(title: "Add Timer"),
            "Add Timer",
            Colors.amber,
            Icon(
              Icons.timer,
              color: Colors.white,
              size: 30,
            ),
          ),
          _addTimer(
            AddTimer(title: "Pomodoro"),
            "Pomodoro",
            Colors.blue,
            Icon(
              Icons.apple_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          _addTimer(
            AddTimer(
              title: "Workout",
            ),
            "Workout",
            Colors.indigo,
            Icon(
              Icons.work,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Container _addTimer(
      Widget goToRoute, String title, Color color, Widget? icon) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Get.to(() => goToRoute);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: 80,
          margin: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
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
                icon ?? Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          'TIMER',
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
