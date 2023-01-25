import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/theme.dart';
import '../add_rest_component.dart';
import '../add_timer_component.dart';
import 'button.dart';

class AddTimerButton extends StatelessWidget {
  const AddTimerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.add,
        size: 40.0,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  "Add Timer",
                  style: titleStyle,
                ),
              ),
              actions: [
                myButton(
                  label: "Add Timer",
                  color: Colors.deepPurple,
                  onTap: () async {
                    await Get.to(() => AddTimerComponent());
                  },
                  buttonWidth: 300,
                ),
                SizedBox(
                  height: 20,
                ),
                myButton(
                  label: "Add Rest Period",
                  color: Colors.green,
                  onTap: () async {
                    await Get.to(() => AddRestComponent());
                  },
                  buttonWidth: 300,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
