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
  
  Future<int> getReminder({Reminder? reminder}) async {
    List<Map<String, dynamic>> reminders = await DbHelper.query();
    reminderlist.assignAll(reminders.map(data)) => new Reminder.fromJson(data)).toList();
  }
  
  void delete(Reminder reminder){
    DBHelper.delete(reminder);
  }
}
