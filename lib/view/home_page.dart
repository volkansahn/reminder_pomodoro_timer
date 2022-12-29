import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_pomodoro/view/pomodoro.dart';
import 'package:reminder_pomodoro/view/reminder_page.dart';

import 'fasting_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_outlined),
            label: 'Reminder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer_sharp),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Fasting Timer',
          ),
        ],
        currentIndex: index,
        selectedItemColor: Colors.amber[800],
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const ReminderPage();
        break;

      case 1:
        widget = const Pomodoro(
          breakTime: '0',
          workSessions: '4',
          workTime: '25',
        );
        break;

      default:
        widget = const FastingTimer();
    }
    return widget;
  }
}
