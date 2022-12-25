import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../models/reminder_model.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var reminderList = <Reminder>[].obs;

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
