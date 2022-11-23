import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';
import 'package:reminder_pomodoro/services/notifications_service.dart';
import 'package:reminder_pomodoro/services/theme_services.dart';
import 'package:reminder_pomodoro/view/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;

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
          _addBar(),
        ],
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
            onTap: null,
          ),
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
            notifyHelper.scheduledNotification();
          },
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
