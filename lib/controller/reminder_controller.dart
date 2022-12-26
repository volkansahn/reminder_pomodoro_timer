import 'package:get/get.dart';
import 'package:reminder_pomodoro/models/water_reminder_model.dart';

import '../helpers/db_helper.dart';
import '../models/reminder_model.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var reminderList = <Reminder>[].obs;

  var waterReminderList = <WaterReminder>[].obs;

  void getWaterReminders() async {
    List<Map<String, dynamic>> waterReminders =
        await DBHelper.waterReminderQuery();
    waterReminderList
        .assignAll(waterReminders.map((e) => WaterReminder.fromJson(e)));
  }

  Future<void> addDrink(int id, int drinkAmount) async {
    await DBHelper.waterReminderAddDrink(id, drinkAmount);
  }

  Future<int> addReminder({Reminder? reminder}) async {
    return await DBHelper.insert(reminder);
  }

  void getReminders() async {
    List<Map<String, dynamic>> reminders = await DBHelper.query();
    reminderList.assignAll(reminders.map((e) => Reminder.fromJson(e)));
  }

  void delete(Reminder reminder) {
    DBHelper.delete(reminder);
  }

  Future<void> markTaskCompleted(int id) async {
    await DBHelper.update(id);
  }
}
