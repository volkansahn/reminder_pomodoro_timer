import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/water_reminder_model.dart';

class AddWaterTile extends StatelessWidget {
  final WaterReminder? waterReminder;
  AddWaterTile(this.waterReminder);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => Get.to(AddWater(waterReminder)),
        child: Container(
            padding: EdgeInsets.all(16),
            //  width: SizeConfig.screenWidth * 0.78,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.amber, //_getBGClr(reminder?.color ?? 0),
            ),
            child: Stack(
            children: <Widget>[
              Container(
                color: Color(0xffABEBC6),
                width: MediaQuery.of(context).size.width,
                height: 4,
              ),
              Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width * (waterReminder.totalDrink / waterReminder.goal),
                height: 4,
              ),
              Row(
                children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                "Drink Water",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                            ),
                                    ),
                                ),
                                SizedBox(
                                    width: 12,
                                ),
                                Text(
                                    '$waterReminder.totalDrink / $waterReminder.goal',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
            ],
          ),
        ),
      ), 
    );
  }
}
