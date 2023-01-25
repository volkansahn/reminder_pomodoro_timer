import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';

class myButton extends StatelessWidget {
  const myButton(
      {super.key,
      required this.label,
      this.onTap,
      required this.buttonWidth,
      required this.color});
  final String label;
  final Function()? onTap;
  final double buttonWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.0,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: color,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
