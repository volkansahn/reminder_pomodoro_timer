import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';

import '../../models/reminder_model.dart';

class ReminderTile extends StatelessWidget {
  final Reminder? reminder;
  ReminderTile(this.reminder);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(6),
                height: (MediaQuery.of(context).size.width) / 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      _getBGClr(reminder!.firstColor!),
                      _getBGClr(reminder!.secondColor!)
                    ],
                  ),
                ),
                child: Text(
                  reminder!.time!,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder?.title ?? "",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            reminder?.date ?? "",
                            style: GoogleFonts.lato(
                              textStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        reminder?.reminder ?? "",
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBGClr(int colorValue) {
    Color newColor = new Color(colorValue);
    return newColor;
  }
}
