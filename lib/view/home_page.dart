import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:reminder_pomodoro/services/notifications_service.dart';
import 'package:reminder_pomodoro/services/theme_services.dart';

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
      appBar: AppBar(
        leading: Column(
          children: [
            SizedBox(
              width: 20,
            ),
            Text("Date"),
          ],
        ),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.add,
              size: 20.0,
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
      ),
      body: Column(
        children: [
          Text(
            "Theme Data",
            style: TextStyle(
              fontSize: 38.0,
            ),
          ),
        ],
      ),
    );
  }
}
