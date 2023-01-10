import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/water_reminder_model.dart';
import '../add_water.dart';

class AddWaterTile extends StatefulWidget {
  final WaterReminder? waterReminder;
  AddWaterTile(this.waterReminder);

  @override
  State<AddWaterTile> createState() => _AddWaterTileState();
}

class _AddWaterTileState extends State<AddWaterTile> {
  late String drinkedWater;
  late String goalValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drinkedWater = widget.waterReminder!.totalDrink!.toStringAsFixed(0);
    goalValue = widget.waterReminder!.goal!.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final Color background = Color.fromARGB(255, 164, 158, 158);
    final Color fill = Colors.blue;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent =
        (widget.waterReminder!.totalDrink! / widget.waterReminder!.goal!) * 100;
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12, top: 12),
      child: GestureDetector(
        onTap: () => Get.to(AddWater(widget.waterReminder)),
        child: Container(
          height: 80,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: gradient,
              stops: stops,
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drink Water",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "$drinkedWater / $goalValue ml",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 18, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getNumber(double input, {int precision = 0}) => double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + 1));
}
