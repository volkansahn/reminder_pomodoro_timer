import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';
import 'package:reminder_pomodoro/view/widgets/add_timer_button.dart';
import 'package:reminder_pomodoro/view/widgets/button.dart';

import '../services/theme_services.dart';
import 'add_rest_component.dart';
import 'add_timer_component.dart';

class AddTimer extends StatefulWidget {
  const AddTimer({super.key, required this.title});
  final String title;
  @override
  State<AddTimer> createState() => _AddTimerState();
}

class _AddTimerState extends State<AddTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(context),
      body: Container(),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: titleStyle,
      ),
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
      actions: [
        AddTimerButton(),
      ],
    );
  }
}
