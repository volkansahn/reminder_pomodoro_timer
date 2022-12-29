import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hp/pages/data.dart';
import 'package:hp/pages/habit.dart';
import 'package:hp/pages/settings.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  int index = 1;
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (selectedIndex){
          setState(() {
            index = selectedIndex;
          });
        },
        index: 1,
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  getSelectedWidget({required int index}) {
    Widget widget;
    switch(index){
      case 0:
        widget = const ReminderPage();
        break;

      case 2:
        widget = const Pomodoro();
        break;

      default:
        widget = const FastingTimer();
    }
    return widget;
  }

}